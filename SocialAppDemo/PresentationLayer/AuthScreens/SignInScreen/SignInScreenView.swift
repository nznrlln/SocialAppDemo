//
//  SignUpScreenView.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 25.03.2023.
//

import UIKit
import SnapKit
import PhoneNumberKit

protocol SignInScreenViewDelegate: AnyObject {
    func nextButtonTapAction(number: String)
}

class SignInScreenView: UIView {

    weak var delegate: SignInScreenViewDelegate?

    private let signInLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interSemiBold18
        label.text = "sign_in".localizable

        return label
    }()

    private let enterNumberLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interMed16
        label.textColor = Palette.thirdText
        label.text = "sign_in_phone".localizable

        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interMed12
        label.textColor = Palette.secondaryText
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "sign_in_phone_description".localizable

        return label
    }()

    private lazy var signInTextField: PhoneNumberTextField = {
        let textField = PhoneNumberTextField()
        textField.toAutoLayout()
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.clipsToBounds = true
        textField.keyboardType = .numberPad
        textField.returnKeyType = .send

        textField.withPrefix = true
        textField.withExamplePlaceholder = true
        textField.withFlag = true

        textField.text = "+16505551111"
        textField.maxDigits = 10

        textField.delegate = self

        return textField
    }()

    private let firstSignInLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interMed12
        label.textColor = Palette.secondaryText
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "first_sign_in_description".localizable

        return label
    }()

    private lazy var nextButton: CustomUIButton = {
        let button = CustomUIButton(
            title: "next".localizable,
            font: Fonts.interMed16,
            titleColor: nil,
            backgroundColor: Palette.darkButton,
            state: .normal
        )
        button.toAutoLayout()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true

        button.customButtonTapAction = { [weak self] in
            if let text = self?.signInTextField.text, !text.isEmpty {
                let number = text
                self?.delegate?.nextButtonTapAction(number: number)
            }
        }

        return button
    }()

    private let agreetmentLabel: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.toAutoLayout()
        textView.isUserInteractionEnabled = true
        textView.isSelectable = true
        textView.isEditable = false
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        let path = "https://www.termsfeed.com/public/uploads/2019/04/privacy-policy-template.pdf"
        let text = "agreetment_description".localizable
        let linkWord = "privacy_policy".localizable
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let attributes = [
            NSAttributedString.Key.font: Fonts.interMed12,
            NSAttributedString.Key.foregroundColor: Palette.secondaryText,
            NSAttributedString.Key.paragraphStyle: paragraph
        ]
        let attrString = NSAttributedString.makeHyperlink(for: path, in: text, as: linkWord, with: attributes)
        textView.attributedText = attrString

        return textView
    }()

    private lazy var viewTapGR = UITapGestureRecognizer(target: self, action: #selector(hideKeybord))

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
        addGestures()
    }

    private func setupSubviews() {
        self.addSubviews(
            signInLabel,
            enterNumberLabel,
            descriptionLabel,
            signInTextField,
            firstSignInLabel,
            nextButton,
            agreetmentLabel
        )
    }

    private func setupSubviewsLayout() {
        signInLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(SignInScreenALConstants.signInLabelTopInset)
            make.centerX.equalToSuperview()
        }

        enterNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(signInLabel.snp.bottom).offset(SignInScreenALConstants.enterNumberLabelTopInset)
            make.centerX.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(enterNumberLabel.snp.bottom).offset(SignInScreenALConstants.descriptionLabelTopInset)
            make.leading.trailing.equalToSuperview().inset(SignInScreenALConstants.descriptionLabelSideInset)
        }

        signInTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(SignInScreenALConstants.signInTextFieldTopInset)
            make.leading.trailing.equalToSuperview().inset(SignInScreenALConstants.signInTextFieldSideInset)
            make.height.equalTo(SignInScreenALConstants.signInTextFieldHeight)
        }

        firstSignInLabel.snp.makeConstraints { make in
            make.top.equalTo(signInTextField.snp.bottom).offset(SignInScreenALConstants.firstSignInLabelTopInset)
            make.leading.trailing.equalToSuperview().inset(SignInScreenALConstants.firstSignInLabelSideInset)
        }

        nextButton.snp.makeConstraints { make in
            make.top.equalTo(signInTextField.snp.bottom).offset(SignInScreenALConstants.nextButtonTopInset)
            make.leading.trailing.equalToSuperview().inset(SignInScreenALConstants.nextButtonSideInset)
            make.height.equalTo(SignInScreenALConstants.nextButtonHeight)
        }

        agreetmentLabel.snp.makeConstraints { make in
            make.top.equalTo(nextButton.snp.bottom).offset(SignInScreenALConstants.agreetmentLabelTopInset)
            make.leading.trailing.equalToSuperview().inset(SignInScreenALConstants.agreetmentLabelSideInset)
            make.height.equalTo(SignInScreenALConstants.agreetmentLabelHeight)
        }
    }

    private func addGestures() {
        self.addGestureRecognizer(viewTapGR)
    }

    @objc private func hideKeybord() {
        self.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate

extension SignInScreenView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        if let text = textField.text, !text.isEmpty {
            let number = text
            delegate?.nextButtonTapAction(number: number)
        }
        return true
    }
}
