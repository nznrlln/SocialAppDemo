//
//  ConfirmSignUpScreenView.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 25.03.2023.
//

import UIKit
import SnapKit

protocol ConfirmSignInScreenViewDelegate: AnyObject {
    func signInButtonTapAction(code: String)
}

final class ConfirmSignInScreenView: UIView {
    
    weak var delegate: ConfirmSignInScreenViewDelegate?

    private var maxDigits: Int = 6
    
    private let confirmSignInLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interSemiBold18
        label.textColor = Palette.mainAccent
        label.text = "sign_in_confirm".localizable
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interReg14
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "code_sent".localizable
        
        return label
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interSemiBold14
        label.text = "3235231"
        
        return label
    }()
    
    private let enterCodeLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interMed16
        label.textColor = Palette.secondaryText
        label.text = "enter_code".localizable
        
        return label
    }()
    
    private lazy var codeTextField: UITextField = {
        let textField = UITextField()
        textField.toAutoLayout()
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.clipsToBounds = true
        
        textField.placeholder = "______"
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.returnKeyType = .send
        
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        return textField
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
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        button.customButtonTapAction = { [weak self] in
            if let text = self?.codeTextField.text, !text.isEmpty {
                let code = text
                self?.delegate?.signInButtonTapAction(code: code)
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

    private lazy var viewTapGR = UITapGestureRecognizer(target: self, action: #selector(hideKeybord))
    
    init(frame: CGRect, number: String) {
        super.init(frame: frame)
        
        viewInitialSettings(number: number)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func viewInitialSettings(number: String) {
        self.backgroundColor = Palette.mainBackground

        numberLabel.text = number
        setupSubviews()
        setupSubviewsLayout()
        addGestures()
    }
    
    private func setupSubviews() {
        self.addSubviews(
            confirmSignInLabel,
            descriptionLabel,
            numberLabel,
            enterCodeLabel,
            codeTextField,
            signInButton,
            checkImageView
        )
    }
    
    private func setupSubviewsLayout() {
        confirmSignInLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(ConfirmSignInScreenALConstants.confirmSignInLabelTopInset)
            make.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(confirmSignInLabel.snp.bottom).offset(ConfirmSignInScreenALConstants.descriptionLabelTopInset)
            make.centerX.equalToSuperview()
        }
        
        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(ConfirmSignInScreenALConstants.numberLabelTopInset)
            make.centerX.equalToSuperview()
        }
        
        enterCodeLabel.snp.makeConstraints { make in
            make.top.equalTo(numberLabel.snp.bottom).offset(ConfirmSignInScreenALConstants.enterCodeLabelTopInset)
            make.leading.equalToSuperview().inset(ConfirmSignInScreenALConstants.enterCodeLabelSideInset)
        }
        
        codeTextField.snp.makeConstraints { make in
            make.top.equalTo(enterCodeLabel.snp.bottom).offset(ConfirmSignInScreenALConstants.codeTextFieldTopInset)
            make.leading.trailing.equalToSuperview().inset(ConfirmSignInScreenALConstants.codeTextFieldSideInset)
            make.height.equalTo(ConfirmSignInScreenALConstants.codeTextFieldHeight)
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(codeTextField.snp.bottom).offset(ConfirmSignInScreenALConstants.signInButtonTopInset)
            make.leading.trailing.equalToSuperview().inset(ConfirmSignInScreenALConstants.signInButtonSideInset)
            make.height.equalTo(ConfirmSignInScreenALConstants.signInButtonHeight)
        }
        
        checkImageView.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(ConfirmSignInScreenALConstants.checkImageViewTopInset)
            make.centerX.equalToSuperview()
            make.height.equalTo(ConfirmSignInScreenALConstants.checkImageViewHeight)
            make.width.equalTo(ConfirmSignInScreenALConstants.checkImageViewWidth)
            
        }
    }

    private func addGestures() {
        self.addGestureRecognizer(viewTapGR)
    }
    
    @objc private func textFieldChanged(_ textField: UITextField) {
        if let num = Int(textField.text!) {
            textField.text = "\(num)"
        } else {
            textField.text = ""
        }
    }

    @objc private func hideKeybord() {
        self.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate

extension ConfirmSignInScreenView: UITextFieldDelegate {

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if (textField.text!.count >= self.maxDigits
            && !string.isEmpty) {
            return false
        }
        let invalidCharacters
        = CharacterSet(charactersIn: "0123456789").inverted
        return (string.rangeOfCharacter(from: invalidCharacters) == nil)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        if let text = textField.text, !text.isEmpty {
            let code = text
            delegate?.signInButtonTapAction(code: code)
        }
        return true
    }
}

