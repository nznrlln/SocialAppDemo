//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Нияз Нуруллин on 08.05.2022.
//

import UIKit
import SnapKit

class ProfileHeaderView: UIView {

    var detailsButtonTapAction: (() -> Void)?

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
        button.setTitle("detailed_information".localizable, for: .normal)
        button.setTitleColor(Palette.blackAndWhite, for: .normal)
        button.titleLabel?.font = Fonts.interMed14
        button.contentHorizontalAlignment = .leading
        button.addTarget(self, action: #selector(detailsButtonTap), for: .touchUpInside)

        return button
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

    override init(frame: CGRect) {
        super.init(frame: frame)

        viewInitialSettings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView(model: UserModel?) {
        guard let model = model else {
            assertionFailure("no user in profile header")
            return
        }

        DispatchQueue.main.async { [weak self] in
            self?.avatarImageView.image = model.avatar
            self?.userNameLabel.text = model.fullname
            self?.userStatusLabel.text = model.status

            self?.postsCountLabel.text = String(model.postsCount ?? 0)
            self?.postsLabel.text = "common_count_of_posts".localizedPlural(arg: model.postsCount ?? 0)

            self?.followingsCountLabel.text = String(model.followingsCount ?? 0)
            self?.followingsLabel.text = "common_count_of_followings".localizedPlural(arg: model.followingsCount ?? 0)

            self?.followersCountLabel.text = String(model.followersCount ?? 0)
            self?.followersLabel.text = "common_count_of_followers".localizedPlural(arg: model.followersCount ?? 0)
        }

    }

    private func viewInitialSettings() {
        self.backgroundColor = .systemBackground

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        self.addSubviews(
            avatarImageView,
            userNameLabel,
            userStatusLabel,
            detailsButton,
            countsStackView,
            labelsStackView,
            separatorView
        )

        countsStackView.addArrangedSubview(postsCountLabel)
        countsStackView.addArrangedSubview(followingsCountLabel)
        countsStackView.addArrangedSubview(followersCountLabel)

        labelsStackView.addArrangedSubview(postsLabel)
        labelsStackView.addArrangedSubview(followingsLabel)
        labelsStackView.addArrangedSubview(followersLabel)
    }

    private func setupSubviewsLayout() {
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
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

        countsStackView.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        labelsStackView.snp.makeConstraints { make in
            make.top.equalTo(countsStackView.snp.bottom)
            make.leading.trailing.equalTo(countsStackView)
        }

        separatorView.snp.makeConstraints { make in
            make.top.equalTo(labelsStackView.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }

    @objc private func detailsButtonTap() {
        detailsButtonTapAction?()
    }

}
