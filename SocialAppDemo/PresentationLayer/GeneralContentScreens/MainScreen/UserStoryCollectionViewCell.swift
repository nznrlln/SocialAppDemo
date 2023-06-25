//
//  UserCollectionViewCell.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 03.04.2023.
//

import UIKit
import SnapKit

final class UserStoryCollectionViewCell: UICollectionViewCell {

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        cellInitialSettings()
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

    // In this situation, you need to specify which trait collection to use to resolve the dynamic color.
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 13.0, *) {
               if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
                   self.layer.borderColor = Palette.mainAccent?.cgColor
               }
           }
    }

    private func cellInitialSettings() {
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
