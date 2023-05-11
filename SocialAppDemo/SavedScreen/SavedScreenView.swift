//
//  SavedScreenView.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 09.04.2023.
//

import UIKit

protocol SavedScreenViewDelegate {
    var numberOfSections: Int? { get }
    var naumberOfRows: Int? { get }

    func getPost(for indexPath: IndexPath) -> SavedPostCoreData?
    func getHeaderTitle(for section: Int) -> String?
}

class SavedScreenView: UIView {

    var delegate: SavedScreenViewDelegate?

    var savedPostsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        tableView.separatorStyle = .none

//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)

        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        viewInitialSettings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func viewInitialSettings() {
        self.backgroundColor = Palette.mainBackground

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        self.addSubview(savedPostsTableView)
    }

    private func setupSubviewsLayout() {
        savedPostsTableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }

}

//// MARK: - UITableViewDataSource
//
//extension SavedScreenView: UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return delegate?.numberOfSections ?? 0
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return delegate?.naumberOfRows ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
//        var content  = cell.defaultContentConfiguration()
//
//        if let model = delegate?.getPost(for: indexPath) {
//            content.text = model.postText
//            content.secondaryText = "author".localizable + (model.authorNickname ?? "nil")
//        }
//
//        cell.contentConfiguration = content
//        cell.accessoryType = .disclosureIndicator
//
//        return cell
//    }
//}
//
//// MARK: - UITableViewDelegate
//
//extension SavedScreenView: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = DateSectionHeaderView()
//        if let title = delegate?.getHeaderTitle(for: section) {
//            headerView.setupHeader(model: title)
//        }
//
//        return headerView
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
////        viewModel.didSelectPost(post: frc.object(at: indexPath))
//    }
//
//    // Override to support conditional editing of the table view.
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//
//
//    // Override to support editing the table view.
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
////            let post = frc.object(at: indexPath)
////            CoreDataManager.defaultManager.deletePost(post: post)
//
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
//}
