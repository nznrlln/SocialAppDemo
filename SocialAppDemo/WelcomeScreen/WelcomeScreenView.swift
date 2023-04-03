//
//  WelcomeScreenView.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 18.03.2023.
//

import UIKit
import SnapKit

protocol WelcomeScreenViewDelegate {
    func signUpButtonTapAction()
    func logInButtonTapAction()
}

class WelcomeScreenView: UIView {

    var delegate: WelcomeScreenViewDelegate?

    private let welcomeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.image = UIImage(named: "Ok")

        return imageView
    }()

    private lazy var signUpButton: CustomUIButton = {
        let button = CustomUIButton(title: "Sign Up".localizable,
                                    font: Fonts.interMed16,
                                    titleColor: nil,
                                    backgroundColor: Palette.darkButton,
                                    state: .normal)
        button.toAutoLayout()
        button.customButtonTapAction = { [weak self] in
            self?.delegate?.signUpButtonTapAction()
        }

        button.layer.cornerRadius = 10
        button.clipsToBounds = true

        return button
    }()

    private lazy var logInButton: CustomUIButton = {
        let button = CustomUIButton(title: "Already have an account".localizable,
                                    font: Fonts.interReg14,
                                    titleColor: Palette.blackAndWhite,
                                    backgroundColor: nil,
                                    state: .normal)
        button.toAutoLayout()
        button.customButtonTapAction = { [weak self] in
            self?.delegate?.logInButtonTapAction()
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
        self.addSubviews(welcomeImageView, signUpButton, logInButton)
    }

    private func setupSubviewsLayout() {
        welcomeImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(WelcomeScreenALConstants.welcomeImageTopInset)
            make.leading.equalToSuperview().inset(WelcomeScreenALConstants.welcomeImageSideInset)
            make.height.width.equalTo(WelcomeScreenALConstants.welcomeImageHeightWidth)
        }

        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(welcomeImageView.snp.bottom).offset(WelcomeScreenALConstants.signUpButtonTopInset)
            make.leading.trailing.equalToSuperview().inset(WelcomeScreenALConstants.signUpButtonSideInset)
            make.height.equalTo(WelcomeScreenALConstants.signUpButtonHeight)
        }

        logInButton.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(WelcomeScreenALConstants.logInButtonTopInset)
            make.centerX.equalToSuperview()
            make.height.equalTo(WelcomeScreenALConstants.logInButtonHeight)
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
