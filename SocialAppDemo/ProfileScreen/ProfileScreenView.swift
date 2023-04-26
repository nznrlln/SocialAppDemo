//
//  ProfileScreenView.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 15.03.2023.
//

import UIKit

class ProfileScreenView: UIView {

    var images = [UIImage]()

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

    private let profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.toAutoLayout()

        return view
    }()

    private let postsCountLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.numberOfLines = 2
        label.font = Fonts.interReg14
        label.text = "10"
        label.textAlignment = .center

        return label
    }()

    private let postsLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.numberOfLines = 2
        label.font = Fonts.interReg14
        label.text = "common_count_of_posts".localizedPlural(arg: 10)
        label.textAlignment = .center

        return label
    }()

    private let followingsCountLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.numberOfLines = 2
        label.font = Fonts.interReg14
        label.text = "333"
        label.textAlignment = .center

        return label
    }()

    private let followingsLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.numberOfLines = 2
        label.font = Fonts.interReg14
        label.text = "common_count_of_followings".localizedPlural(arg: 333)
        label.textAlignment = .center

        return label
    }()

    private let followersCountLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.numberOfLines = 2
        label.font = Fonts.interReg14
        label.text = "999"
        label.textAlignment = .center

        return label
    }()

    private let followersLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.numberOfLines = 2
        label.font = Fonts.interReg14
        label.text = "common_count_of_followers".localizedPlural(arg: 999)
        label.textAlignment = .center

        return label
    }()

    private let countsStackView: UIStackView = {
        let stack = UIStackView()
        stack.toAutoLayout()
        stack.axis = .horizontal
        stack.distribution = .fillEqually

        return stack
    }()

    private let labelsStackView: UIStackView = {
        let stack = UIStackView()
        stack.toAutoLayout()
        stack.axis = .horizontal
        stack.distribution = .fillEqually

        return stack
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

    private let photosLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.numberOfLines = 2
        label.font = Fonts.interMed16
        label.text = "photos".localizable

        return label
    }()

    private let showPhotosButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = Palette.blackAndWhite
//        button.addTarget(self, action: #selector(photosButtonTap), for: .touchUpInside)

        return button
    }()

    private lazy var photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.toAutoLayout()
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.register(MiniPhotosCollectionViewCell.self, forCellWithReuseIdentifier: MiniPhotosCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }()

    private lazy var postsTableView: PostsTableView = {
        let tableView = PostsTableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        tableView.backgroundColor = Palette.mainBackground

        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        viewInitialSettings()

        FirebaseStorageManager.shared.getPhotoCollectionList() { [weak self] imageRefs in
            guard let imageRefs = imageRefs else { return }

            for ref in imageRefs {
                FirebaseStorageManager.shared.getImage(ref: ref) { image in
                    guard let image = image else { return }
                    self?.images.append(image)
                    self?.photosCollectionView.reloadData()
                }
            }
        }

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
        countsStackView.addArrangedSubview(postsCountLabel)
        countsStackView.addArrangedSubview(followingsCountLabel)
        countsStackView.addArrangedSubview(followersCountLabel)

        labelsStackView.addArrangedSubview(postsLabel)
        labelsStackView.addArrangedSubview(followingsLabel)
        labelsStackView.addArrangedSubview(followersLabel)

        contentView.addSubviews(profileHeaderView,
                         countsStackView,
                         labelsStackView,
                         separatorView,
                         photosLabel, showPhotosButton,
                         photosCollectionView,
                         postsTableView)

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
        
        profileHeaderView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(contentView)
        }

        countsStackView.snp.makeConstraints { make in
            make.top.equalTo(profileHeaderView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(contentView).inset(16)
        }

        labelsStackView.snp.makeConstraints { make in
            make.top.equalTo(countsStackView.snp.bottom)
            make.leading.trailing.equalTo(countsStackView)
        }

        separatorView.snp.makeConstraints { make in
            make.top.equalTo(labelsStackView.snp.bottom).offset(15)
            make.leading.trailing.equalTo(contentView).inset(16)
            make.height.equalTo(0.5)
        }

        photosLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(22)
            make.leading.equalTo(contentView).inset(16)
        }

        showPhotosButton.snp.makeConstraints { make in
            make.centerY.equalTo(photosLabel)
            make.trailing.equalTo(contentView).inset(16)
            make.height.width.equalTo(24)
        }

        photosCollectionView.snp.makeConstraints { make in
            make.top.equalTo(photosLabel.snp.bottom).offset(15)
            make.leading.trailing.equalTo(contentView).inset(16)
            make.trailing.equalTo(contentView)
            make.height.equalTo(100)
        }

        postsTableView.snp.makeConstraints { make in
            make.top.equalTo(photosCollectionView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(contentView)
            make.bottom.equalTo(contentView)
            make.height.equalTo(700)
        }
    }

}

// MARK: - UICollectionViewDataSource

extension ProfileScreenView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MiniPhotosCollectionViewCell.identifier, for: indexPath) as! MiniPhotosCollectionViewCell
        cell.setupCell(model: images[indexPath.item])

        return cell
    }


}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProfileScreenView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 72, height: 66)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }



}
