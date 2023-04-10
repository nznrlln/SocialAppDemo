//
//  HomeScreenView.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 02.04.2023.
//

import UIKit

class MainScreenView: UIView {

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
        self.addSubviews(usersCollectionView, postsTableView)
    }

    private func setupSubviewsLayout() {
        usersCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(MainScreenALConstants.collectionTopInset)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(60)
        }

        postsTableView.snp.makeConstraints { make in
            make.top.equalTo(usersCollectionView.snp.bottom).offset(MainScreenALConstants.tableViewTopInset)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()

        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

// MARK: - UICollectionViewDataSource

extension MainScreenView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCollectionViewCell.identifier, for: indexPath) as! UserCollectionViewCell
//        cell.setupCell(model: <#T##UIImage#>)

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


}

// MARK: - UITableViewDataSource

extension MainScreenView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier) as! PostTableViewCell

        return cell
    }


}

// MARK: - UITableViewDelegate

extension MainScreenView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 380
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 380
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        return footer
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postVC = PostScreenViewController()
        
    }
}
