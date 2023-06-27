//
//  HomeScreenView.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 02.04.2023.
//

import UIKit

protocol MainScreenViewDelegate: AnyObject {
    var users: [UserModel] { get }
    var posts: [String?: [PostModel]] { get }
    var postsDates: [String] { get }

    func didSelectStory(story: UIImage, cell: UserStoryCollectionViewCell, xOffset: CGFloat)
    func didSelectPost(post: PostModel, author: UserModel)

    func didSaveTap(post: PostModel, author: UserModel)
}

final class MainScreenView: UIView {

    weak var delegate: MainScreenViewDelegate?

    private var cellXOffset: CGFloat?

    private enum Section {
        case stories
        case posts
    }

    private var sections: [Section] = []

    private lazy var collectionLayout: UICollectionViewLayout = {
        UICollectionViewCompositionalLayout { (section, environmet) -> NSCollectionLayoutSection? in
            let sectionType = self.sections[section]
            let contentSize = environmet.container.contentSize

            switch sectionType {
            case .stories:
                let numberOfItems = MainScreenALConstants.numberOfStories
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(60),
                    heightDimension: .absolute(60)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupWidth: CGFloat = CGFloat(numberOfItems * 60 + (numberOfItems - 1) * 12)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .estimated(groupWidth),
                    heightDimension: .absolute(MainScreenALConstants.collectionHeight)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    repeatingSubitem: item,
                    count: numberOfItems
                )
                group.interItemSpacing = .fixed(12)

                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(
                    top: MainScreenALConstants.collectionTopInset,
                    leading: MainScreenALConstants.collectionSideInset,
                    bottom: MainScreenALConstants.collectionTopInset,
                    trailing: MainScreenALConstants.collectionSideInset
                )
                section.interGroupSpacing = 12
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
            UserStoryCollectionViewCell.self,
            forCellWithReuseIdentifier: UserStoryCollectionViewCell.identifier
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


    func updateUsersView() {
        setupSections()
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    func updatePostsView() {
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
        let basicSections: [Section] = [.stories]
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

extension MainScreenView: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = self.sections[section]

        switch sectionType {
        case .stories:
            return delegate?.users.count ?? 0
            
        case .posts:
            guard let dateKey = delegate?.postsDates[section - 1] else { return 0 }
            guard let values = delegate?.posts[dateKey] else { return 0 }

            return values.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = self.sections[indexPath.section]

        switch sectionType {

        case .stories:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: UserStoryCollectionViewCell.identifier,
                for: indexPath
            ) as! UserStoryCollectionViewCell
            cell.setupCellWith(model: delegate?.users[indexPath.item])

            return cell

        case .posts:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostCollectionViewCell.identifier,
                for: indexPath
            ) as! PostCollectionViewCell

            let dateKey = delegate?.postsDates[indexPath.section - 1]
            if let datePosts = delegate?.posts[dateKey] {
                let postData = datePosts[indexPath.item]
                guard let author = delegate?.users.first(where: { $0.userUID == postData.authorUID }) else { return cell }
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

            headerView.setupHeader(model: delegate?.postsDates[indexPath.section - 1])

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

extension MainScreenView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = self.sections[indexPath.section]

        switch sectionType {
        case .stories:
            guard let user = delegate?.users[indexPath.item] else { return }
            guard let cell = collectionView.cellForItem(at: indexPath) as? UserStoryCollectionViewCell else { return }

            // получаем координаты точки начала род. вью
            let viewstart = self.frame.origin
            // переводим координаты нач. точки в систему координат нашей ячейки
            let point = self.convert(viewstart, to: cell.coordinateSpace)
            // получаем отступ (со знаком минус), делаем положительным и прибавляем половину ширины ячейки для получения центра х
            self.cellXOffset = -1 * point.x + cell.frame.width / 2

            delegate?.didSelectStory(
                story: user.avatar ?? UIImage(),
                cell: cell,
                xOffset: self.cellXOffset ?? 0
            )
        case .posts:
            collectionView.deselectItem(at: indexPath, animated: true)

            if let dateKey = delegate?.postsDates[indexPath.section - 1],
               let datePosts = delegate?.posts[dateKey] {
                let postData = datePosts[indexPath.item]
                guard let author = delegate?.users.first(where: { $0.userUID == postData.authorUID }) else { return }
                delegate?.didSelectPost(post: postData, author: author)
            }
        }
    }

}
