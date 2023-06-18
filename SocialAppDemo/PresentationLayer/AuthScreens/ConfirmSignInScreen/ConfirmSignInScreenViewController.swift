//
//  ConfirmSignUpScreenViewController.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 25.03.2023.
//

import UIKit
import SnapKit

class ConfirmSignInScreenViewController: UIViewController {

    weak var coordinator: AuthCoordinator?

    private(set) var accountPhoneNumber: String!

    private lazy var mainView: ConfirmSignInScreenView = {
        let view = ConfirmSignInScreenView(frame: .zero, number: accountPhoneNumber)
        view.toAutoLayout()
        view.delegate = self

        return view
    }()

    init(accountPhoneNumber: String!) {
        self.accountPhoneNumber = accountPhoneNumber

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewInitialSettings()
    }

    private func viewInitialSettings() {
        view.backgroundColor = Palette.mainBackground

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        view.addSubview(mainView)
    }

    private func setupSubviewsLayout() {
        mainView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - ConfirmSignUpScreenViewDelegate

extension ConfirmSignInScreenViewController: ConfirmSignInScreenViewDelegate {
    func signInButtonTapAction(code: String) {
        AuthManager.shared.verifyCode(smsCode: code) { [weak self] success in
            guard success else { return }
            DispatchQueue.main.async {
                self?.coordinator?.openGeneralContent()
            }
        }
    }


}
