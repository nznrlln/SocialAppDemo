//
//  LogInScreenView.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 23.03.2023.
//

import UIKit
import SnapKit

protocol LogInScreenViewDelegate {
    func confirmButtonTapAction()
}

class LogInScreenView: UIView {

    var delegate: LogInScreenViewDelegate?

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interSemiBold18
        label.textColor = Palette.mainAccent
        label.text = "Welcome back".localizable

        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interReg14
//        label.textColor = Palette.mainAccent
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Enter your phone number to log in".localizable

        return label
    }()

    private let logInTextField: UITextField = {
        let textField = UITextField()
        textField.toAutoLayout()
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.clipsToBounds = true

        textField.placeholder = "+7___-___-__-__"
        textField.textAlignment = .center

        return textField
    }()

    private lazy var confirmButton: CustomUIButton = {
        let button = CustomUIButton(title: "CONFIRM".localizable,
                                    font: Fonts.interMed16,
                                    titleColor: nil,
                                    backgroundColor: Palette.darkButton,
                                    state: .normal)
        button.toAutoLayout()
        button.customButtonTapAction = { [weak self] in
            self?.delegate?.confirmButtonTapAction()
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
        self.addSubviews(welcomeLabel,
                         descriptionLabel,
                         logInTextField,
                         confirmButton)
    }

    private func setupSubviewsLayout() {
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(LogInScreenALConstants.welcomeLabelTopInset)
            make.centerX.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(LogInScreenALConstants.descriptionLabelTopInset)
            make.leading.trailing.equalToSuperview().inset(LogInScreenALConstants.descriptionLabelSideInset)
        }

        logInTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(LogInScreenALConstants.logInTextFieldTopInset)
            make.leading.trailing.equalToSuperview().inset(LogInScreenALConstants.logInTextFieldSideInset)
            make.height.equalTo(LogInScreenALConstants.logInTextFieldHeight)
        }

        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(logInTextField.snp.bottom).offset(LogInScreenALConstants.confirmButtonTopInset)
            make.leading.trailing.equalToSuperview().inset(LogInScreenALConstants.confirmButtonSideInset)
            make.height.equalTo(LogInScreenALConstants.confirmButtonHeight)
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
