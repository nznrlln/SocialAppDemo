//
//  ProfileScreenView.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 15.03.2023.
//

import UIKit

protocol ProfileScreenViewDelegate: AnyObject {
    var user: UserModel { get }

    var images: [UIImage] { get }

    var posts: [String?: [PostModel]] { get }
    var postsDates: [String] { get }

    func didTapDetails()
    func didSelectPhoto()
    func didSelectPost(post: PostModel, author: UserModel)
    func didSaveTap(post: PostModel, author: UserModel)

}

class ProfileScreenView: UIView {

    weak var delegate: ProfileScreenViewDelegate?

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false

        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.toAutoLayout()

        return view
    }()

    private let profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.toAutoLayout()

        return view
    }()

    private let photosLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.numberOfLines = 2
        label.font = Fonts.interMed16
        label.text = "photos".localizable

        return label
    }()

    private lazy var showPhotosButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = Palette.blackAndWhite
        button.addTarget(self, action: #selector(photosButtonTap), for: .touchUpInside)

        return button
    }()

    private lazy var photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.toAutoLayout()
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.register(
            MiniPhotosCollectionViewCell.self,
            forCellWithReuseIdentifier: MiniPhotosCollectionViewCell.identifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }()

    private lazy var postsTableView: PostsTableView = {
        let tableView = PostsTableView(
            frame: .zero,
            style: .grouped,
            posts: nil,
            postsDates: nil,
            authors: nil
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

    func updateProfile() {
        DispatchQueue.main.async { [weak self] in
            self?.profileHeaderView.setupView(model: self?.delegate?.user)
        }

    }

    func updatePhotos() {
        DispatchQueue.main.async { [weak self] in

            self?.photosCollectionView.reloadData()
        }
    }

    func updatePosts() {
        postsTableView.posts = delegate?.posts ?? [:]
        postsTableView.postsDates = delegate?.postsDates ?? []

        let user = delegate?.user ?? UserModel()
        postsTableView.authors = [user]

        DispatchQueue.main.async { [weak self] in
            self?.postsTableView.reloadData()
        }
    }

    private func viewInitialSettings() {
        self.backgroundColor = Palette.mainBackground

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubviews(
            profileHeaderView,
            photosLabel, showPhotosButton,
            photosCollectionView,
            postsTableView
        )
    }

    private func setupSubviewsLayout() {
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        profileHeaderView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(contentView)
        }

        photosLabel.snp.makeConstraints { make in
            make.top.equalTo(profileHeaderView.snp.bottom).offset(22)
            make.leading.equalTo(contentView).inset(16)
        }

        showPhotosButton.snp.makeConstraints { make in
            make.centerY.equalTo(photosLabel)
            make.trailing.equalTo(contentView).inset(16)
            make.height.width.equalTo(24)
        }

        photosCollectionView.snp.makeConstraints { make in
            make.top.equalTo(photosLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(contentView).inset(16)
            make.height.equalTo(80)
        }

        postsTableView.snp.makeConstraints { make in
            make.top.equalTo(photosCollectionView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(contentView)
            make.bottom.equalTo(contentView)
            make.height.equalTo(700)
        }
    }

    @objc private func photosButtonTap() {
        self.delegate?.didSelectPhoto()
    }
}

// MARK: - UIScrollViewDelegate

extension ProfileScreenView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        // если пролистываем скроллвью
        if scrollView == self.scrollView {
            // когда точка контента скроллвью сдвинется от начальной больше, чем на 200 - у таблицы вкл прокуртка
                postsTableView.isScrollEnabled = (self.scrollView.contentOffset.y >= 200)
            }

        // если пролистываем таблицу
        if scrollView == self.postsTableView {
            // когда точка контента таблицы совпадет с началом таблицы - у таблицы откл прокрутка
            self.postsTableView.isScrollEnabled = (postsTableView.contentOffset.y > 0)
        }

    }
}

// MARK: - UICollectionViewDataSource

extension ProfileScreenView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.images.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MiniPhotosCollectionViewCell.identifier, for: indexPath) as! MiniPhotosCollectionViewCell
        if let model = delegate?.images[indexPath.item] {
            cell.setupCell(model: model)
        }

        return cell
    }


}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProfileScreenView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 72, height: 66)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectPhoto()
    }

}

// MARK: - PostsTableViewDelegate

extension ProfileScreenView: PostsTableViewDelegate {
    func didSaveTap(post: PostModel, author: UserModel) {
        self.delegate?.didSaveTap(post: post, author: author)
    }

    func didSelectPost(post: PostModel, author: UserModel) {
        self.delegate?.didSelectPost(post: post, author: author)
    }
}
