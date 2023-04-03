//
//  ConfirmSignUpScreenViewController.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 25.03.2023.
//

import UIKit
import SnapKit

class ConfirmSignUpScreenViewController: UIViewController {

    private lazy var mainView: ConfirmSignUpScreenView = {
        let view = ConfirmSignUpScreenView()
        view.toAutoLayout()
        view.delegate = self

        return view
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewInitialSettings()
    }

    private func viewInitialSettings() {
        view.backgroundColor = .white

        setupSubviews()
        setupSubviewsLayout()
    }

    private func setupSubviews() {
        view.addSubview(mainView)
    }

    private func setupSubviewsLayout() {
        mainView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - ConfirmSignUpScreenViewDelegate
extension ConfirmSignUpScreenViewController: ConfirmSignUpScreenViewDelegate {
    func signUpButtonTapAction(code: String) {
        AuthManager.shared.verifyCode(smsCode: code) { [weak self] success in
            guard success else { return }
            DispatchQueue.main.async {
                let tabbarVC = MainTabBarController()
                self?.navigationController?.pushViewController(tabbarVC, animated: true)
            }
        }
    }


}
