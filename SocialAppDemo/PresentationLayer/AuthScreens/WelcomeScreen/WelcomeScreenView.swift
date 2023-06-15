//
//  WelcomeScreenView.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 18.03.2023.
//

import UIKit
import SnapKit

protocol WelcomeScreenViewDelegate: AnyObject {
    func signUpButtonTapAction()
}

class WelcomeScreenView: UIView {

    weak var delegate: WelcomeScreenViewDelegate?

    private let welcomeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.image = UIImage(named: "Ok")

        return imageView
    }()

    private lazy var signInButton: CustomUIButton = {
        let button = CustomUIButton(
            title: "sign_in".localizable,
            font: Fonts.interMed16,
            titleColor: nil,
            backgroundColor: Palette.darkButton,
            state: .normal
        )
        button.toAutoLayout()
        button.customButtonTapAction = { [weak self] in
            self?.delegate?.signUpButtonTapAction()
        }

        button.layer.cornerRadius = 10
        button.clipsToBounds = true

        return button
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
        self.addSubviews(welcomeImageView, signInButton)
    }

    private func setupSubviewsLayout() {
        welcomeImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(WelcomeScreenALConstants.welcomeImageTopInset)
            make.leading.equalToSuperview().inset(WelcomeScreenALConstants.welcomeImageSideInset)
            make.height.width.equalTo(WelcomeScreenALConstants.welcomeImageHeightWidth)
        }

        signInButton.snp.makeConstraints { make in
            make.top.equalTo(welcomeImageView.snp.bottom).offset(WelcomeScreenALConstants.signInButtonTopInset)
            make.leading.trailing.equalToSuperview().inset(WelcomeScreenALConstants.signInButtonSideInset)
            make.height.equalTo(WelcomeScreenALConstants.signInButtonHeight)
        }
    }
    
}
