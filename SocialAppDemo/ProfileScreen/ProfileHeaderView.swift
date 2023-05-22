//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Нияз Нуруллин on 08.05.2022.
//

import UIKit
import SnapKit

class ProfileHeaderView: UIView {

    private let avatarImageView: UIImageView = {
        let avatar = UIImageView()
        avatar.toAutoLayout()

        avatar.layer.cornerRadius = 40
        avatar.layer.borderWidth = 2
        avatar.layer.borderColor = Palette.mainAccent?.cgColor
        avatar.clipsToBounds = true

        return avatar
    }()

    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interSemiBold18
        label.text = "User"

        return label
    }()

    private let userStatusLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interReg14
        label.textColor = Palette.secondaryText
        label.text = "Status"

        return label
    }()

    private lazy var detailsButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setImage(UIImage(systemName:"info.circle.fill"), for: .normal)
        button.tintColor = Palette.mainAccent
        button.setTitle("Подробная информация", for: .normal)
        button.setTitleColor(Palette.blackAndWhite, for: .normal)
        button.titleLabel?.font = Fonts.interMed14
        button.contentHorizontalAlignment = .leading

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        viewInitialSettings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView(model: UserModel?) {
        guard let model = model else { assertionFailure("no user in profile header"); return }

        DispatchQueue.main.async { [weak self] in
            self?.avatarImageView.image = model.avatar
            self?.userNameLabel.text = model.fullname
            self?.userStatusLabel.text = model.status
        }

    }

    private func viewInitialSettings() {
        self.backgroundColor = .systemBackground

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        self.addSubviews(avatarImageView,
                         userNameLabel,
                         userStatusLabel,
                         detailsButton)
    }

    private func setupSubviewsLayout() {
        avatarImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(15)
            make.leading.equalToSuperview().inset(34)
            make.height.width.equalTo(80)
        }

        userNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview().inset(34)
        }

        userStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(3)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview().inset(34)
        }

        detailsButton.snp.makeConstraints { make in
            make.top.equalTo(userStatusLabel.snp.bottom).offset(3)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview().inset(34)
        }
    }

}
