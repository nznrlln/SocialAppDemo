//
//  SignUpScreenView.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 25.03.2023.
//

import UIKit
import SnapKit

protocol SignUpScreenViewDelegate {
    func nextButtonTapAction(number: String)
}

class SignUpScreenView: UIView {

    var delegate: SignUpScreenViewDelegate?

    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interSemiBold18
        label.text = "Sign Up".localizable

        return label
    }()

    private let enterNumberLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interMed16
        label.textColor = Palette.thirdText
        label.text = "Enter phone number".localizable

        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interMed12
        label.textColor = Palette.secondaryText
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Your phone number would be used to log into your account".localizable

        return label
    }()

    private lazy var signUpTextField: UITextField = {
        let textField = UITextField()
        textField.toAutoLayout()
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.clipsToBounds = true

        textField.placeholder = "+7___-___-__-__"
        textField.textAlignment = .center

        textField.delegate = self
        textField.returnKeyType = .send

        return textField
    }()

    private lazy var nextButton: CustomUIButton = {
        let button = CustomUIButton(title: "NEXT".localizable,
                                    font: Fonts.interMed16,
                                    titleColor: nil,
                                    backgroundColor: Palette.darkButton,
                                    state: .normal)
        button.toAutoLayout()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true

        button.customButtonTapAction = { [weak self] in
            if let text = self?.signUpTextField.text, !text.isEmpty {
                let number = "+1\(text)"
                self?.delegate?.nextButtonTapAction(number: number)
            }
        }

        return button
    }()

    private let agreetmentLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interMed12
        label.textColor = Palette.secondaryText
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "By pressing “Next” you are agreeing to all terms and conditions of our privacy policy".localizable

        return label
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
        self.addSubviews(signUpLabel,
                         enterNumberLabel,
                         descriptionLabel,
                         signUpTextField,
                         nextButton,
                         agreetmentLabel)
    }

    private func setupSubviewsLayout() {

        signUpLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(SignUpScreenALConstants.signUpLabelTopInset)
            make.centerX.equalToSuperview()
        }

        enterNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpLabel.snp.bottom).offset(SignUpScreenALConstants.enterNumberLabelTopInset)
            make.centerX.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(enterNumberLabel.snp.bottom).offset(SignUpScreenALConstants.descriptionLabelTopInset)
            make.leading.trailing.equalToSuperview().inset(SignUpScreenALConstants.descriptionLabelSideInset)
        }

        signUpTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(SignUpScreenALConstants.signUpTextFieldTopInset)
            make.leading.trailing.equalToSuperview().inset(SignUpScreenALConstants.signUpTextFieldSideInset)
            make.height.equalTo(SignUpScreenALConstants.signUpTextFieldHeight)
        }

        nextButton.snp.makeConstraints { make in
            make.top.equalTo(signUpTextField.snp.bottom).offset(SignUpScreenALConstants.nextButtonTopInset)
            make.leading.trailing.equalToSuperview().inset(SignUpScreenALConstants.nextButtonSideInset)
            make.height.equalTo(SignUpScreenALConstants.nextButtonHeight)
        }

        agreetmentLabel.snp.makeConstraints { make in
            make.top.equalTo(nextButton.snp.bottom).offset(SignUpScreenALConstants.agreetmentLabelTopInset)
            make.leading.trailing.equalToSuperview().inset(SignUpScreenALConstants.agreetmentLabelSideInset)
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

// MARK: - UITextFieldDelegate

extension SignUpScreenView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        if let text = textField.text, !text.isEmpty {
            let number = "+1\(text)"
            delegate?.nextButtonTapAction(number: number)
        }
        return true
    }
}
