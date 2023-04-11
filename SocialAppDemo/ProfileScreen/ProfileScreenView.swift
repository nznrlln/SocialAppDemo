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
        label.numberOfLines = 2
        label.font = Fonts.interReg14
        label.text = "10" + "\nposts"
        label.textAlignment = .center

        return label
    }()

    private let subscribersCountLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.numberOfLines = 2
        label.font = Fonts.interReg14
        label.text = "999" + "\nsubscribers"
        label.textAlignment = .center

        return label
    }()

    private let subscriptionCountLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.numberOfLines = 2
        label.font = Fonts.interReg14
        label.text = "333" + "\nsubscribtions"
        label.textAlignment = .center

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
        collectionView.dataSource = self
        collectionView.delegate = self

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
                         photosCollectionView,
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
            make.top.equalTo(postsCountLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(26)
            make.height.equalTo(0.5)
        }

        photosCollectionView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }

        postsTableView.snp.makeConstraints { make in
            make.top.equalTo(photosCollectionView.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

}

extension ProfileScreenView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCollectionViewCell.identifier, for: indexPath) as! UserCollectionViewCell

        return cell
    }


}


extension ProfileScreenView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 72, height: 68)
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
}
