//
//  SavedScreenViewController.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 09.04.2023.
//

import UIKit
import SnapKit
import CoreData

class SavedScreenViewController: UIViewController {

    private let mainView: SavedScreenView

    private lazy var frc: NSFetchedResultsController<SavedPostCoreData> = {
        let request = SavedPostCoreData.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "postCreationDate", ascending: false)] //

        let frc = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: CoreDataManager.shared.mainContext,
            sectionNameKeyPath: "postCreationDate",
            cacheName: nil
        )
        return frc
    }()

    init(mainView: SavedScreenView) {
        self.mainView = mainView

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        setupFRC()
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewInitialSettings()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    private func setupFRC() {
        frc.delegate = self
        do {
            try frc.performFetch()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }

    private func viewInitialSettings() {
        view.backgroundColor = .white

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        view.addSubview(mainView)
        mainView.toAutoLayout()

        mainView.savedPostsTableView.dataSource = self
        mainView.savedPostsTableView.delegate = self
        mainView.savedPostsTableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: UITableViewCell.identifier
        )
    }

    private func setupSubviewsLayout() {
        mainView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

}


// MARK: - NSFetchedResultsControllerDelegate

extension SavedScreenViewController: NSFetchedResultsControllerDelegate {

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }

            // If the post added to core data was first, and created a section by one - then insert the section to table view, else insert row
            if mainView.savedPostsTableView.numberOfSections < frc.sections!.count {
                mainView.savedPostsTableView.insertSections(IndexSet(integer: newIndexPath.section), with: .automatic)
            } else {
                mainView.savedPostsTableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .delete:
            guard let indexPath = indexPath else { return }

            // If the post deleted from core data was last in section, and reduced sections by one - then Delete the section from table view, else delete row
            if mainView.savedPostsTableView.numberOfSections > frc.sections!.count {
                mainView.savedPostsTableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
            } else {
                mainView.savedPostsTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .move:
            guard let indexPath = indexPath, let newIndexPath = newIndexPath else { return }
            mainView.savedPostsTableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else { return }
            mainView.savedPostsTableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            mainView.savedPostsTableView.reloadData()
            debugPrint("Fatal error")
        }
    }
    
}

// MARK: - UITableViewDataSource

extension SavedScreenViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return frc.sections?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frc.sections?[section].numberOfObjects ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
        var content  = cell.defaultContentConfiguration()

        let model = frc.object(at: indexPath)
        content.text = model.postText
        content.textProperties.numberOfLines = 3
        content.secondaryText = "author".localizable + (model.authorNickname ?? "nil")

        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator

        return cell
    }
}

// MARK: - UITableViewDelegate

extension SavedScreenViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = DateSectionHeaderView()

        let title = frc.sections?[section].name
        headerView.setupHeader(model: title)

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        26
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = Palette.mainBackground

        return footer
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        20
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let dataModel = CoreDataHelper.shared.getModels(from: frc.object(at: indexPath))

        let model = PostScreenModel(post: dataModel.post, author: dataModel.user)
        let view = PostScreenView()
        let vc = PostScreenViewController(model: model, mainView: view)

        self.navigationController!.pushViewController(vc, animated: true)
    }

    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let post = frc.object(at: indexPath)
            CoreDataManager.shared.deletePost(post: post)
        }
    }
}

