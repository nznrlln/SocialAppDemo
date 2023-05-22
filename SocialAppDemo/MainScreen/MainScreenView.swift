//
//  HomeScreenView.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 02.04.2023.
//

import UIKit

protocol MainScreenViewDelegate {
    var users: [UserModel] { get }
    var posts: [String?: [PostModel]] { get }
    var postsDates: [String] { get }

    func didSelectUser(userUID: String)
    func didSelectPost(post: PostModel, author: UserModel)

    func didSaveTap(post: PostModel, author: UserModel)
}

class MainScreenView: UIView {

    var delegate: MainScreenViewDelegate?

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()

        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.toAutoLayout()

        return view
    }()

    private lazy var usersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.toAutoLayout()
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: UserCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }()

//    private lazy var postsTableView: UITableView = {
//        let tableView = UITableView(frame: .zero, style: .plain)
//        tableView.toAutoLayout()
////        tableView.backgroundColor = Palette.mainAccent
//
//        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
//        tableView.dataSource = self
//        tableView.delegate = self
//
//        return tableView
//    }(

    private lazy var postsTableView: PostsTableView = {
        let tableView = PostsTableView(frame: .zero,
                                       style: .grouped,
                                       posts: delegate?.posts,
                                       postsDates: delegate?.postsDates,
                                       authors: delegate?.users)
        tableView.toAutoLayout()
        tableView.backgroundColor = Palette.mainBackground

        tableView.tvDelegate = self

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

    func updateUsersView() {
        DispatchQueue.main.async { [weak self] in
            self?.usersCollectionView.reloadData()
        }
    }

    func updatePostsView() {
        postsTableView.posts = delegate?.posts ?? [:]
        postsTableView.postsDates = delegate?.postsDates ?? []
        postsTableView.authors = delegate?.users ?? []

        DispatchQueue.main.async { [weak self] in
            self?.postsTableView.reloadData()
        }
    }

    private func setupSubviews() {
        contentView.addSubviews(usersCollectionView, postsTableView)
        scrollView.addSubview(contentView)
        self.addSubview(scrollView)
    }

    private func setupSubviewsLayout() {
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        usersCollectionView.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(MainScreenALConstants.collectionTopInset)
            make.leading.trailing.equalTo(contentView).inset(16)
            make.height.equalTo(60)
        }

        postsTableView.snp.makeConstraints { make in
            make.top.equalTo(usersCollectionView.snp.bottom).offset(MainScreenALConstants.tableViewTopInset)
            make.leading.trailing.equalTo(contentView)
            make.bottom.equalTo(contentView)
            make.height.equalTo(700)
        }
    }

}

// MARK: - UICollectionViewDataSource

extension MainScreenView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.users.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCollectionViewCell.identifier, for: indexPath) as! UserCollectionViewCell
        cell.setupCellWith(model: delegate?.users[indexPath.item])

        return cell
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainScreenView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let user = delegate?.users[indexPath.item] else { return }

        delegate?.didSelectUser(userUID: user.userUID)
    }


}

//// MARK: - UITableViewDataSource
////
//extension MainScreenView: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return delegate?.posts.count ?? 2
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return delegate?.posts[section].values.count ?? 3
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier) as! PostTableViewCell
//        cell.setupCellWith(model: delegate?.posts[indexPath.section].values[indexPath.row])
//
//        return cell
//    }
//
//}

//// MARK: - UITableViewDelegate
//
//extension MainScreenView: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 380
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 380
//    }
//
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footer = UIView()
//        return footer
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        0
//    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let postVC = PostScreenViewController()
//
//    }
//}


//// MARK: - PostsTableViewDataSource
//
//extension MainScreenView: PostsTableViewDataSource {
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 380
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 380
//    }
//
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footer = UIView()
//        return footer
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        0
//    }
//}

// MARK: - PostsTableViewDelegate

extension MainScreenView: PostsTableViewDelegate {
    func didSaveTap(post: PostModel, author: UserModel) {
        self.delegate?.didSaveTap(post: post, author: author)
    }

    func didSelectPost(post: PostModel, author: UserModel) {
        self.delegate?.didSelectPost(post: post, author: author)
    }

}
