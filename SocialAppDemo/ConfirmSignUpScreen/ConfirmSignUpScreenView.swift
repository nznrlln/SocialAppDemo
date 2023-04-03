//
//  ConfirmSignUpScreenView.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 25.03.2023.
//

import UIKit
import SnapKit

protocol ConfirmSignUpScreenViewDelegate {
    func signUpButtonTapAction(code: String)
}

class ConfirmSignUpScreenView: UIView {

    var delegate: ConfirmSignUpScreenViewDelegate?

    private let confirmSignUpLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interSemiBold18
        label.textColor = Palette.mainAccent
        label.text = "Confirm Sign Up".localizable

        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interReg14
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "We sent the code via SMS to number".localizable

        return label
    }()

    private let numberLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interSemiBold14
//        label.textColor = Palette.secondaryText
        label.text = "3235231"

        return label
    }()

    private let enterCodeLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interMed16
        label.textColor = Palette.secondaryText
        label.text = "Enter code from SMS".localizable

        return label
    }()

    private lazy var codeTextField: UITextField = {
        let textField = UITextField()
        textField.toAutoLayout()
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.clipsToBounds = true

        textField.placeholder = "_-_-_-_"
        textField.textAlignment = .center

        textField.delegate = self
        textField.returnKeyType = .send

        return textField
    }()

    private lazy var signUpButton: CustomUIButton = {
        let button = CustomUIButton(title: "NEXT".localizable,
                                    font: Fonts.interMed16,
                                    titleColor: nil,
                                    backgroundColor: Palette.darkButton,
                                    state: .normal)
        button.toAutoLayout()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true

        button.customButtonTapAction = { [weak self] in
            if let text = self?.codeTextField.text, !text.isEmpty {
                let code = text
                self?.delegate?.signUpButtonTapAction(code: code)
            }
        }

        return button
    }()

    private let checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.image = UIImage(named: "CheckMark")

        return imageView
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
        self.addSubviews(confirmSignUpLabel,
                         descriptionLabel,
                         numberLabel,
                         enterCodeLabel,
                         codeTextField,
                         signUpButton,
                         checkImageView)
    }

    private func setupSubviewsLayout() {
        confirmSignUpLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(ConfirmSignUpScreenALConstants.confirmSignUpLabelTopInset)
            make.centerX.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(confirmSignUpLabel.snp.bottom).offset(ConfirmSignUpScreenALConstants.descriptionLabelTopInset)
            make.centerX.equalToSuperview()
        }

        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(ConfirmSignUpScreenALConstants.numberLabelTopInset)
            make.centerX.equalToSuperview()
        }

        enterCodeLabel.snp.makeConstraints { make in
            make.top.equalTo(numberLabel.snp.bottom).offset(ConfirmSignUpScreenALConstants.enterCodeLabelTopInset)
            make.leading.equalToSuperview().inset(ConfirmSignUpScreenALConstants.enterCodeLabelSideInset)
        }

        codeTextField.snp.makeConstraints { make in
            make.top.equalTo(enterCodeLabel.snp.bottom).offset(ConfirmSignUpScreenALConstants.codeTextFieldTopInset)
            make.leading.trailing.equalToSuperview().inset(ConfirmSignUpScreenALConstants.codeTextFieldSideInset)
            make.height.equalTo(ConfirmSignUpScreenALConstants.codeTextFieldHeight)
        }

        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(codeTextField.snp.bottom).offset(ConfirmSignUpScreenALConstants.signUpButtonTopInset)
            make.leading.trailing.equalToSuperview().inset(ConfirmSignUpScreenALConstants.signUpButtonSideInset)
            make.height.equalTo(ConfirmSignUpScreenALConstants.signUpButtonHeight)
        }

        checkImageView.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(ConfirmSignUpScreenALConstants.checkImageViewTopInset)
            make.centerX.equalToSuperview()
            make.height.equalTo(ConfirmSignUpScreenALConstants.checkImageViewHeight)
            make.width.equalTo(ConfirmSignUpScreenALConstants.checkImageViewWidth)

        }
    }

}

// MARK: - UITextFieldDelegate

extension ConfirmSignUpScreenView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        if let text = textField.text, !text.isEmpty {
            let code = text
            delegate?.signUpButtonTapAction(code: code)
        }
        return true
    }
}

