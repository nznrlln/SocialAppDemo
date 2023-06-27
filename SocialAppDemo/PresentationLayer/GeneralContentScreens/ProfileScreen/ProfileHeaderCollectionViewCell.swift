//
//  ProfileHeaderCollectionViewCell.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 25.06.2023.
//

import UIKit

class ProfileHeaderCollectionViewCell: UICollectionViewCell {

    var detailsButtonTapAction: (() -> Void)?
    var photosButtonTapAction: (() -> Void)?


    lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.toAutoLayout()
        view.detailsButtonTapAction = { [weak self] in
            self?.detailsButtonTapAction?()
        }

        return view
    }()

    private let photosLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.numberOfLines = 2
        label.font = Fonts.interMed16
        label.text = "photos".localizable

        return label
    }()

    private lazy var showPhotosButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = Palette.blackAndWhite
        button.addTarget(self, action: #selector(photosButtonTap), for: .touchUpInside)

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        cellInitialSettings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func cellInitialSettings() {
        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        self.contentView.addSubviews(
            profileHeaderView,
            photosLabel,
            showPhotosButton
        )
    }

    private func setupSubviewsLayout() {
        profileHeaderView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }

        photosLabel.snp.makeConstraints { make in
            make.top.equalTo(profileHeaderView.snp.bottom).offset(ProfileScreenALConstants.photosLabelTopInset)
            make.leading.equalToSuperview().inset(ProfileScreenALConstants.generalSideInset)
        }

        showPhotosButton.snp.makeConstraints { make in
            make.centerY.equalTo(photosLabel)
            make.trailing.equalToSuperview().inset(ProfileScreenALConstants.generalSideInset)
            make.bottom.equalToSuperview()
            make.height.width.equalTo(ProfileScreenALConstants.photosButtonHeightWidth)
        }
    }

    @objc private func photosButtonTap() {
        self.photosButtonTapAction?()
    }

}
