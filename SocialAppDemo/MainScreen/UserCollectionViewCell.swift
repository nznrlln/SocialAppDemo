//
//  UserCollectionViewCell.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 03.04.2023.
//

import UIKit
import SnapKit

class UserCollectionViewCell: UICollectionViewCell {

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        cellInitialSetting()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCellWith(model: UserModel?) {
        guard let model = model else { return }
        avatarImageView.image = model.avatar
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        avatarImageView.image = nil
    }

    private func cellInitialSetting() {
//        self.contentView.backgroundColor = .blue
        self.layer.cornerRadius = 30
        self.layer.borderWidth = 0.5
        self.layer.borderColor = Palette.mainAccent?.cgColor
        self.clipsToBounds = true

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        self.contentView.addSubview(avatarImageView)
    }

    private func setupSubviewsLayout() {
        avatarImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
