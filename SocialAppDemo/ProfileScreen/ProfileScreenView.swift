//
//  ProfileScreenView.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 15.03.2023.
//

import UIKit

class ProfileScreenView: UIView {
//
//    /*
//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//    }
//    */
//
//    private lazy var tableView: UITableView = {
//        let tableView = UITableView(frame: .zero, style: .grouped)
//        tableView.toAutoLayout()
//        tableView.backgroundColor = self.view.backgroundColor
//
//        tableView.dataSource = self
//        tableView.delegate = self
////        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
////        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
//
//        return tableView
//    }()
//
//    private lazy var doubleTapGR: UITapGestureRecognizer = {
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(doubleTapAction))
//        gesture.numberOfTapsRequired = 2
//
//        return gesture
//    }()
//
////    init(viewModel: ProfileViewModel) {
////        self.viewModel = viewModel
////        super.init(nibName: nil, bundle: nil)
////        self.viewModel.showUserData()
////    }
//
////    required init?(coder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
////    }
//
////    override func viewDidLoad() {
////        super.viewDidLoad()
////
////        // Do any additional setup after loading the view.
////        viewInitialSettings()
////    }
//
////    override func viewWillAppear(_ animated: Bool) {
////        super.viewWillAppear(animated)
////
////        self.navigationController?.isNavigationBarHidden = true
////    }
//
//    private func viewInitialSettings() {
//        navigationItem.title = "Profile".localizable
//        navigationController?.navigationBar.backgroundColor = Palette.whiteAndBlack
//        view.backgroundColor = Palette.profileBackground
//
//        setupSubviews()
//        setupSubviewsLayout()
//    }
//
//    private func setupSubviews() {
//        tableView.addGestureRecognizer(doubleTapGR)
//        view.addSubview(tableView)
//    }
//
//    private func setupSubviewsLayout(){
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//        ])
//    }
//
//    @objc private func doubleTapAction() {
//
//        let point = doubleTapGR.location(in: tableView)
//        guard let indexPath = tableView.indexPathForRow(at: point) else {
//            debugPrint("no indexPath")
//            return
//        }
//
//        if indexPath.section == 1 {
//            print("👏🏻👏🏻👏🏻")
////            viewModel.didSavePost(post: viewModel.posts[indexPath.row])
//        }
//
//    }
//
}
//
//// MARK: - UITableViewDataSource
//
//extension ProfileViewController: UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return 1
//        default:
//            return viewModel.posts.count
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        switch indexPath.section {
//        case 0:
//            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as! PhotosTableViewCell
//            cell.photosButtonTapAction = { [weak self] in
//                self?.viewModel.showGallery()
//            }
//
//            return cell
//        default:
//            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
//            cell.setupCell(model: viewModel.posts[indexPath.row])
//
//            return cell
//        }
//
//    }
//}
//
//// MARK: - UITableViewDelegate
//
//extension ProfileViewController: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        UITableView.automaticDimension
//    }
//
//
//    // метод для хедера
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        switch section {
//        case 0:
//            let header = ProfileHeaderView()
//            return header
//        default:
//            let header = UIView()
//            return header
//        }
//    }
//
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footer = UIView()
//        return footer
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        if indexPath.section == 0 {
//            viewModel.showGallery()
//        }
//    }
//}
//
