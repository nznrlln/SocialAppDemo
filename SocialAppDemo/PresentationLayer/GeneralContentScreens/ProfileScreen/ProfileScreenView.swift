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

final class ProfileScreenView: UIView {

    weak var delegate: ProfileScreenViewDelegate?

    private enum Section {
        case profile
        case photos
        case posts
    }

    private var sections: [Section] = []

    private lazy var collectionLayout: UICollectionViewLayout = {
        UICollectionViewCompositionalLayout { (section, environmet) -> NSCollectionLayoutSection? in
            let sectionType = self.sections[section]
            let contentSize = environmet.container.contentSize

            switch sectionType {
            case .profile:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(250)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(250)
                )
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: groupSize,
                    repeatingSubitem: item,
                    count: 1
                )

                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(
                    top: 0,
                    leading: 0,
                    bottom: 0,
                    trailing: 0
                )

                return section

            case .photos:
                let numberOfItems = ProfileScreenALConstants.numberOfPhotos
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(72),
                    heightDimension: .absolute(66)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupWidth: CGFloat = CGFloat(numberOfItems * 72 + (numberOfItems - 1) * 4)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(groupWidth),
                    heightDimension: .estimated(80)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                group.interItemSpacing = .fixed(4)

                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(
                    top: ProfileScreenALConstants.photosCollectionTopInset,
                    leading: ProfileScreenALConstants.generalSideInset,
                    bottom: ProfileScreenALConstants.photosCollectionTopInset,
                    trailing: ProfileScreenALConstants.generalSideInset
                )
                section.orthogonalScrollingBehavior = .continuous

                return section

            case .posts:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(380)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(380)
                )
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: groupSize,
                    repeatingSubitem: item,
                    count: 1
                )

                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(
                    top: 0,
                    leading: 0,
                    bottom: 0,
                    trailing: 0
                )
                section.boundarySupplementaryItems = [
                    NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: NSCollectionLayoutSize(
                            widthDimension: .fractionalWidth(1.0),
                            heightDimension: .absolute(26)
                        ),
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top
                    ),
                    NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: NSCollectionLayoutSize(
                            widthDimension: .fractionalWidth(1.0),
                            heightDimension: .absolute(20)
                        ),
                        elementKind: UICollectionView.elementKindSectionFooter,
                        alignment: .bottom
                    )
                ]

                return section
            }
        }
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.toAutoLayout()
        collectionView.backgroundColor = Palette.mainBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = false

        collectionView.register(
            ProfileHeaderCollectionViewCell.self,
            forCellWithReuseIdentifier: ProfileHeaderCollectionViewCell.identifier
        )
        collectionView.register(
            MiniPhotosCollectionViewCell.self,
            forCellWithReuseIdentifier: MiniPhotosCollectionViewCell.identifier
        )
        collectionView.register(
            PostCollectionViewCell.self,
            forCellWithReuseIdentifier: PostCollectionViewCell.identifier
        )

        collectionView.register(
            DateSectionHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: DateSectionHeaderCollectionReusableView.identifier
        )
        collectionView.register(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: UICollectionReusableView.identifier
        )

        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        viewInitialSettings()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateProfile() {
        setupSections()
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    func updatePhotos() {
        setupSections()
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    func updatePosts() {
        setupSections()
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    private func viewInitialSettings() {
        self.backgroundColor = Palette.mainBackground

        setupSections()
        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSections() {
        let basicSections: [Section] = [.profile, .photos]
        let postSections: [Section] = Array(repeating: .posts, count: delegate?.postsDates.count ?? 0)

        self.sections = basicSections + postSections
    }

    private func setupSubviews() {
        self.addSubview(collectionView)
    }

    private func setupSubviewsLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }

    }
}


// MARK: - UICollectionViewDataSource

extension ProfileScreenView: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = self.sections[section]

        switch sectionType {
        case .profile:
            return 1

        case .photos:
            return delegate?.images.count ?? 0
            
        case .posts:
            guard let dateKey = delegate?.postsDates[section - 2] else { return 0 }
            guard let values = delegate?.posts[dateKey] else { return 0 }

            return values.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = self.sections[indexPath.section]

        switch sectionType {
        case .profile:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProfileHeaderCollectionViewCell.identifier,
                for: indexPath
            ) as! ProfileHeaderCollectionViewCell

            if let model = delegate?.user {
                cell.profileHeaderView.setupView(model: model)
            }

            cell.detailsButtonTapAction = { [weak self] in
                self?.delegate?.didTapDetails()
            }
            cell.photosButtonTapAction = { [weak self] in
                self?.delegate?.didSelectPhoto()
            }

            return cell

        case .photos:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MiniPhotosCollectionViewCell.identifier,
                for: indexPath
            ) as! MiniPhotosCollectionViewCell
            if let model = delegate?.images[indexPath.item] {
                cell.setupCell(model: model)
            }
            return cell

        case .posts:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostCollectionViewCell.identifier,
                for: indexPath
            ) as! PostCollectionViewCell

            let dateKey = delegate?.postsDates[indexPath.section - 2]
            if let datePosts = delegate?.posts[dateKey] {
                let postData = datePosts[indexPath.item]
                guard let author = delegate?.user else { return cell }
                cell.setupCellWith(model: postData, author: author)

                cell.saveButtonTapAction = { [weak self] in
                    self?.delegate?.didSaveTap(post: postData, author: author)
                }
            }

            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: DateSectionHeaderCollectionReusableView.identifier,
                for: indexPath
            ) as! DateSectionHeaderCollectionReusableView

            headerView.setupHeader(model: delegate?.postsDates[indexPath.section - 2])

            return headerView

        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: UICollectionReusableView.identifier,
                for: indexPath
            )

            return footerView

        default:
            assert(false, "Unexpected element kind")
        }
    }

}

// MARK: - UICollectionViewDelegate

extension ProfileScreenView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = self.sections[indexPath.section]

        switch sectionType {
        case .profile:
            return
        case .photos:
            delegate?.didSelectPhoto()
        case .posts:
            collectionView.deselectItem(at: indexPath, animated: true)

            if let dateKey = delegate?.postsDates[indexPath.section - 2],
               let datePosts = delegate?.posts[dateKey] {
                let postData = datePosts[indexPath.item]
                guard let author = delegate?.user else { return }
                delegate?.didSelectPost(post: postData, author: author)
            }
        }
    }

}

//
//final class ProfileScreenView: UIView {
//
//    weak var delegate: ProfileScreenViewDelegate?
//
//    private lazy var scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.toAutoLayout()
//        scrollView.delegate = self
//        scrollView.showsVerticalScrollIndicator = false
//
//        return scrollView
//    }()
//
//    private let contentView: UIView = {
//        let view = UIView()
//        view.toAutoLayout()
//
//        return view
//    }()
//
//    private lazy var profileHeaderView: ProfileHeaderView = {
//        let view = ProfileHeaderView()
//        view.toAutoLayout()
//        view.detailsButtonTapAction = { [weak self] in
//            self?.delegate?.didTapDetails()
//        }
//
//        return view
//    }()
//
//    private let photosLabel: UILabel = {
//        let label = UILabel()
//        label.toAutoLayout()
//        label.numberOfLines = 2
//        label.font = Fonts.interMed16
//        label.text = "photos".localizable
//
//        return label
//    }()
//
//    private lazy var showPhotosButton: UIButton = {
//        let button = UIButton()
//        button.toAutoLayout()
//        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
//        button.tintColor = Palette.blackAndWhite
//        button.addTarget(self, action: #selector(photosButtonTap), for: .touchUpInside)
//
//        return button
//    }()
//
//    private lazy var photosCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.toAutoLayout()
//        collectionView.showsHorizontalScrollIndicator = false
//
//        collectionView.register(
//            MiniPhotosCollectionViewCell.self,
//            forCellWithReuseIdentifier: MiniPhotosCollectionViewCell.identifier
//        )
//        collectionView.dataSource = self
//        collectionView.delegate = self
//
//        return collectionView
//    }()
//
//    private lazy var postsTableView: PostsTableView = {
//        let tableView = PostsTableView(
//            frame: .zero,
//            style: .grouped,
//            posts: nil,
//            postsDates: nil,
//            authors: nil
//        )
//        tableView.toAutoLayout()
//        tableView.backgroundColor = Palette.mainBackground
//        tableView.bounces = false
//        tableView.isScrollEnabled = false
//        tableView.showsVerticalScrollIndicator = false
//
//        tableView.tvDelegate = self
//
//        return tableView
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        viewInitialSettings()
//    }
//
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func updateProfile() {
//        DispatchQueue.main.async { [weak self] in
//            self?.profileHeaderView.setupView(model: self?.delegate?.user)
//        }
//
//    }
//
//    func updatePhotos() {
//        DispatchQueue.main.async { [weak self] in
//
//            self?.photosCollectionView.reloadData()
//        }
//    }
//
//    func updatePosts() {
//        postsTableView.posts = delegate?.posts ?? [:]
//        postsTableView.postsDates = delegate?.postsDates ?? []
//
//        let user = delegate?.user ?? UserModel()
//        postsTableView.authors = [user]
//
//        DispatchQueue.main.async { [weak self] in
//            self?.postsTableView.reloadData()
//        }
//    }
//
//    private func viewInitialSettings() {
//        self.backgroundColor = Palette.mainBackground
//
//        setupSubviews()
//        setupSubviewsLayout()
//    }
//
//    private func setupSubviews() {
//        self.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//
//        contentView.addSubviews(
//            profileHeaderView,
//            photosLabel, showPhotosButton,
//            photosCollectionView,
//            postsTableView
//        )
//    }
//
//    private func setupSubviewsLayout() {
//        scrollView.snp.makeConstraints { make in
//            make.top.leading.trailing.bottom.equalToSuperview()
//        }
//
//        contentView.snp.makeConstraints { make in
//            make.top.leading.trailing.bottom.equalTo(scrollView)
//            make.width.equalTo(scrollView)
//        }
//
//        profileHeaderView.snp.makeConstraints { make in
//            make.top.leading.trailing.equalTo(contentView)
//        }
//
//        photosLabel.snp.makeConstraints { make in
//            make.top.equalTo(profileHeaderView.snp.bottom).offset(ProfileScreenALConstants.photosLabelTopInset)
//            make.leading.equalTo(contentView).inset(ProfileScreenALConstants.generalSideInset)
//        }
//
//        showPhotosButton.snp.makeConstraints { make in
//            make.centerY.equalTo(photosLabel)
//            make.trailing.equalTo(contentView).inset(ProfileScreenALConstants.generalSideInset)
//            make.height.width.equalTo(ProfileScreenALConstants.photosButtonHeightWidth)
//        }
//
//        photosCollectionView.snp.makeConstraints { make in
//            make.top.equalTo(photosLabel.snp.bottom).offset(ProfileScreenALConstants.photosCollectionTopInset)
//            make.leading.trailing.equalTo(contentView).inset(ProfileScreenALConstants.generalSideInset)
//            make.height.equalTo(ProfileScreenALConstants.photosCollectionHeight)
//        }
//
//        postsTableView.snp.makeConstraints { make in
//            make.top.equalTo(photosCollectionView.snp.bottom).offset(ProfileScreenALConstants.tableViewTopInset)
//            make.leading.trailing.equalTo(contentView)
//            make.bottom.equalTo(contentView)
//            make.height.equalTo(ProfileScreenALConstants.tableViewHeight)
//        }
//    }
//
//    @objc private func photosButtonTap() {
//        self.delegate?.didSelectPhoto()
//    }
//}
//
//// MARK: - UIScrollViewDelegate
//
//extension ProfileScreenView: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        // если пролистываем скроллвью
//        if scrollView == self.scrollView {
//            // когда точка контента скроллвью сдвинется от начальной больше, чем на 200 - у таблицы вкл прокуртка
//                postsTableView.isScrollEnabled = (self.scrollView.contentOffset.y >= 200)
//            }
//
//        // если пролистываем таблицу
//        if scrollView == self.postsTableView {
//            // когда точка контента таблицы совпадет с началом таблицы - у таблицы откл прокрутка
//            self.postsTableView.isScrollEnabled = (postsTableView.contentOffset.y > 0)
//        }
//
//    }
//}
//
//// MARK: - UICollectionViewDataSource
//
//extension ProfileScreenView: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return delegate?.images.count ?? 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(
//            withReuseIdentifier: MiniPhotosCollectionViewCell.identifier,
//            for: indexPath
//        ) as! MiniPhotosCollectionViewCell
//
//        if let model = delegate?.images[indexPath.item] {
//            cell.setupCell(model: model)
//        }
//
//        return cell
//    }
//
//
//}
//
//// MARK: - UICollectionViewDelegateFlowLayout
//
//extension ProfileScreenView: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 72, height: 66)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 4
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.delegate?.didSelectPhoto()
//    }
//
//}
//
//// MARK: - PostsTableViewDelegate
//
//extension ProfileScreenView: PostsTableViewDelegate {
//    func didSaveTap(post: PostModel, author: UserModel) {
//        self.delegate?.didSaveTap(post: post, author: author)
//    }
//
//    func didSelectPost(post: PostModel, author: UserModel) {
//        self.delegate?.didSelectPost(post: post, author: author)
//    }
//}
