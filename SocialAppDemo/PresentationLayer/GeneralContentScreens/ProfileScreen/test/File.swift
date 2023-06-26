//
//  File.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 25.06.2023.
//

import UIKit
import SwiftUI

//protocol ProfileScreenViewDelegate: AnyObject {
//    var user: UserModel { get }
//
//    var images: [UIImage] { get }
//
//    var posts: [String?: [PostModel]] { get }
//    var postsDates: [String] { get }
//
//    func didTapDetails()
//    func didSelectPhoto()
//    func didSelectPost(post: PostModel, author: UserModel)
//    func didSaveTap(post: PostModel, author: UserModel)
//
//}

//final class ProfileScreenView2: UIView {
//
//    weak var delegate: ProfileScreenViewDelegate?
//
//    private enum Section {
//        case profile
//        case photos
//        case posts
//    }
//
//    private var sections: [Section] = []
//
//    private lazy var collectionLayout: UICollectionViewLayout = {
//        UICollectionViewCompositionalLayout { (section, environmet) -> NSCollectionLayoutSection? in
//            let sectionType = self.sections[section]
//            let contentSize = environmet.container.contentSize
//
//            switch sectionType {
//            case .profile:
//                let itemSize = NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1.0),
//                    heightDimension: .estimated(250)
//                )
//                let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//                let groupSize = NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1.0),
//                    heightDimension: .estimated(250)
//                )
//                let group = NSCollectionLayoutGroup.vertical(
//                    layoutSize: groupSize,
//                    repeatingSubitem: item,
//                    count: 1
//                )
//
//                let section = NSCollectionLayoutSection(group: group)
//                section.contentInsets = NSDirectionalEdgeInsets(
//                    top: 0,
//                    leading: 0,
//                    bottom: 0,
//                    trailing: 0
//                )
//
//                return section
//
//            case .photos:
//                let numberOfItems = ProfileScreenALConstants.numberOfPhotos
//                let itemSize = NSCollectionLayoutSize(
//                    widthDimension: .absolute(72),
//                    heightDimension: .absolute(66)
//                )
//                let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//                let groupWidth: CGFloat = CGFloat(numberOfItems * 72 + (numberOfItems - 1) * 4)
//                let groupSize = NSCollectionLayoutSize(
//                    widthDimension: .absolute(groupWidth),
//                    heightDimension: .estimated(78)
//                )
//                let group = NSCollectionLayoutGroup.horizontal(
//                    layoutSize: groupSize,
//                    subitems: [item]
//                )
//                group.interItemSpacing = .fixed(4)
//
//                let section = NSCollectionLayoutSection(group: group)
//                section.contentInsets = NSDirectionalEdgeInsets(
//                    top: ProfileScreenALConstants.photosCollectionTopInset,
//                    leading: 16,
//                    bottom: 0,
//                    trailing: 0
//                )
//                section.orthogonalScrollingBehavior = .continuous
//
//                return section
//
//            case .posts:
//                let itemSize = NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1.0),
//                    heightDimension: .absolute(380)
//                )
//                let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//                let groupSize = NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1.0),
//                    heightDimension: .absolute(380)
//                )
//                let group = NSCollectionLayoutGroup.vertical(
//                    layoutSize: groupSize,
//                    repeatingSubitem: item,
//                    count: 1
//                )
//
//                let section = NSCollectionLayoutSection(group: group)
//                section.contentInsets = NSDirectionalEdgeInsets(
//                    top: 0,
//                    leading: 0,
//                    bottom: 0,
//                    trailing: 0
//                )
//
//                return section
//            }
//        }
//    }()
//
//    lazy var collectionView: UICollectionView = {
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
//        collectionView.toAutoLayout()
//        collectionView.backgroundColor = Palette.mainBackground
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.showsVerticalScrollIndicator = false
//        collectionView.alwaysBounceVertical = false
//
//        collectionView.register(
//            ProfileHeaderCollectionViewCell.self,
//            forCellWithReuseIdentifier: ProfileHeaderCollectionViewCell.identifier
//        )
//        collectionView.register(
//            MiniPhotosCollectionViewCell.self,
//            forCellWithReuseIdentifier: MiniPhotosCollectionViewCell.identifier
//        )
//        collectionView.register(
//            PostCollectionViewCell.self,
//            forCellWithReuseIdentifier: PostCollectionViewCell.identifier
//        )
//
//        collectionView.dataSource = self
//        collectionView.delegate = self
//
//        return collectionView
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
//        setupSections()
//
//        DispatchQueue.main.async { [weak self] in
//            self?.collectionView.reloadData()
//        }
//
//
//    }
//
//    func updatePhotos() {
//        setupSections()
//
//        DispatchQueue.main.async { [weak self] in
//            self?.collectionView.reloadData()
//        }
//    }
//
//    func updatePosts() {
//        setupSections()
//
//        DispatchQueue.main.async { [weak self] in
//            self?.collectionView.reloadData()
//        }
//    }
//
//    private func viewInitialSettings() {
//        self.backgroundColor = Palette.mainBackground
//
//        setupSections()
//        setupSubviews()
//        setupSubviewsLayout()
//    }
//
//    private func setupSections() {
//        let basicSections: [Section] = [.profile, .photos]
//        let postSections: [Section] = Array(repeating: .posts, count: delegate?.postsDates.count ?? 0)
//
//        self.sections = basicSections + postSections
//    }
//
//    private func setupSubviews() {
//        self.addSubview(collectionView)
//    }
//
//    private func setupSubviewsLayout() {
//        collectionView.snp.makeConstraints { make in
//            make.top.leading.trailing.bottom.equalToSuperview()
//        }
//
//    }
//}
//
//
//// MARK: - UICollectionViewDataSource
//
//extension ProfileScreenView2: UICollectionViewDataSource {
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return self.sections.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let sectionType = self.sections[section]
//
//        switch sectionType {
//        case .profile:
//            return 1
//        case .photos:
//            return delegate?.images.count ?? 0
//        case .posts:
//            guard let dateKey = delegate?.postsDates[section - 2] else { return 0 }
//            guard let values = delegate?.posts[dateKey] else { return 0 }
//
//            return values.count
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let sectionType = self.sections[indexPath.section]
//
//        switch sectionType {
//        case .profile:
//            let cell = collectionView.dequeueReusableCell(
//                withReuseIdentifier: ProfileHeaderCollectionViewCell.identifier,
//                for: indexPath
//            ) as! ProfileHeaderCollectionViewCell
//
//            if let model = delegate?.user {
//                cell.profileHeaderView.setupView(model: model)
//            }
//
//            cell.detailsButtonTapAction = { [weak self] in
//                self?.delegate?.didTapDetails()
//            }
//            cell.photosButtonTapAction = { [weak self] in
//                self?.delegate?.didSelectPhoto()
//            }
//
//            return cell
//
//        case .photos:
//            let cell = collectionView.dequeueReusableCell(
//                withReuseIdentifier: MiniPhotosCollectionViewCell.identifier,
//                for: indexPath
//            ) as! MiniPhotosCollectionViewCell
//            if let model = delegate?.images[indexPath.item] {
//                cell.setupCell(model: model)
//            }
//            return cell
//
//        case .posts:
//            let cell = collectionView.dequeueReusableCell(
//                withReuseIdentifier: PostCollectionViewCell.identifier,
//                for: indexPath
//            ) as! PostCollectionViewCell
//
//            let dateKey = delegate?.postsDates[indexPath.section - 2]
//            if let models = delegate?.posts[dateKey] {
//                let postData = models[indexPath.item]
//                guard let author = delegate?.user else { return cell }
//                cell.setupCellWith(model: postData, author: author)
//
//                cell.saveButtonTapAction = { [weak self] in
//                    self?.delegate?.didSaveTap(post: postData, author: author)
//                }
//            }
//
//            return cell
//        }
//    }
//
//}
//
//// MARK: - UICollectionViewDelegate
//
//extension ProfileScreenView2: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath.section)
//        let sectionType = self.sections[indexPath.section]
//
//        switch sectionType {
//        case .profile:
//            return
//        case .photos:
//            delegate?.didSelectPhoto()
//        case .posts:
//            collectionView.deselectItem(at: indexPath, animated: true)
//
//            if let dateKey = delegate?.postsDates[indexPath.section - 2],
//               let model = delegate?.posts[dateKey] {
//                let postData = model[indexPath.item]
//                guard let author = delegate?.user else { return }
//                delegate?.didSelectPost(post: postData, author: author)
//            }
//        }
//    }
//}
