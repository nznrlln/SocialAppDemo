//
//  ProfileScreenView.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 15.03.2023.
//

import UIKit

class ProfileScreenView: UIView {

    private let profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.toAutoLayout()

        return view
    }()

    private let postsCountLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interReg14

        return label
    }()

    private let subscribersCountLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interReg14

        return label
    }()

    private let subscriptionCountLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interReg14

        return label
    }()

    private let separatorView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        view.backgroundColor = Palette.secondaryText

        return view
    }()

    private let addPostButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()

        return button
    }()

    private let addStoriesButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()

        return button
    }()

    private let addPhotosButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()

        return button
    }()

    private lazy var photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.toAutoLayout()
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: UserCollectionViewCell.identifier)
//        collectionView.dataSource = self
//        collectionView.delegate = self

        return collectionView
    }()

    private lazy var postsTableView: PostsTableView = {
        let tableView = PostsTableView(frame: .zero, style: .plain)
        tableView.toAutoLayout()

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
        self.addSubviews(profileHeaderView,
                         postsCountLabel,
                         subscribersCountLabel,
                         subscriptionCountLabel,
                         separatorView,
                         postsTableView)
    }

    private func setupSubviewsLayout() {

        profileHeaderView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }

        postsCountLabel.snp.makeConstraints { make in
            make.top.equalTo(profileHeaderView.snp.bottom).offset(35)
            make.leading.equalToSuperview().inset(26)
        }

        subscribersCountLabel.snp.makeConstraints { make in
            make.top.equalTo(profileHeaderView.snp.bottom).offset(35)
            make.centerX.equalToSuperview()

        }

        subscriptionCountLabel.snp.makeConstraints { make in
            make.top.equalTo(profileHeaderView.snp.bottom).offset(35)
            make.trailing.equalToSuperview().inset(26)
        }
        separatorView.snp.makeConstraints { make in

        }
    }


    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */

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
