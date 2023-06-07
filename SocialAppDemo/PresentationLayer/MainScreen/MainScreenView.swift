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

    func didSelectUser(user: UserModel, cell: UserStoryCollectionViewCell, xOffset: CGFloat)
    func didSelectPost(post: PostModel, author: UserModel)

    func didSaveTap(post: PostModel, author: UserModel)
}

class MainScreenView: UIView {

    var delegate: MainScreenViewDelegate?

    private var cellXOffset: CGFloat?

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        scrollView.bounces = true

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

        collectionView.register(
            UserStoryCollectionViewCell.self,
            forCellWithReuseIdentifier: UserStoryCollectionViewCell.identifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }()

    private lazy var postsTableView: PostsTableView = {
        let tableView = PostsTableView(
            frame: .zero,
            style: .grouped,
            posts: delegate?.posts,
            postsDates: delegate?.postsDates,
            authors: delegate?.users
        )
        tableView.toAutoLayout()
        tableView.backgroundColor = Palette.mainBackground
        tableView.bounces = false
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false

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
            make.leading.trailing.equalTo(contentView).inset(MainScreenALConstants.collectionSideInset)
            make.height.equalTo(MainScreenALConstants.collectionHeight)
        }

        postsTableView.snp.makeConstraints { make in
            make.top.equalTo(usersCollectionView.snp.bottom).offset(MainScreenALConstants.tableViewTopInset)
            make.leading.trailing.equalTo(contentView)
            make.bottom.equalTo(contentView)
            make.height.equalTo(MainScreenALConstants.tableViewHeight)
        }
    }

}

// MARK: - UIScrollViewDelegate

extension MainScreenView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        // если пролистываем скроллвью
        if scrollView == self.scrollView {
            // когда точка контента скроллвью сдвинется от начальной больше, чем на 50 - у таблицы вкл прокуртка
                postsTableView.isScrollEnabled = (self.scrollView.contentOffset.y > 60)
            }

        // если пролистываем таблицу
        if scrollView == self.postsTableView {
            // когда точка контента таблицы совпадет с началом таблицы - у таблицы откл прокрутка
            self.postsTableView.isScrollEnabled = (postsTableView.contentOffset.y > 0)
        }

        if scrollView == self.usersCollectionView {
            self.cellXOffset = scrollView.contentOffset.x
        }

    }
}

// MARK: - UICollectionViewDataSource

extension MainScreenView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.users.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: UserStoryCollectionViewCell.identifier,
            for: indexPath
        ) as! UserStoryCollectionViewCell
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
        guard let cell = collectionView.cellForItem(at: indexPath) as? UserStoryCollectionViewCell else { return }

        delegate?.didSelectUser(
            user: user,
            cell: cell,
            xOffset: self.cellXOffset ?? 0
        )
    }


}


// MARK: - PostsTableViewDelegate

extension MainScreenView: PostsTableViewDelegate {
    func didSaveTap(post: PostModel, author: UserModel) {
        self.delegate?.didSaveTap(post: post, author: author)
    }

    func didSelectPost(post: PostModel, author: UserModel) {
        self.delegate?.didSelectPost(post: post, author: author)
    }

}
