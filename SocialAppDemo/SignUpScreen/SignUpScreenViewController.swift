//
//  SignUpScreenViewController.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 25.03.2023.
//

import UIKit
import SnapKit

class SignUpScreenViewController: UIViewController {

    private lazy var mainView: SignUpScreenView = {
        let view = SignUpScreenView()
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

// MARK: - SignUpScreenViewDelegate
extension SignUpScreenViewController: SignUpScreenViewDelegate {
    func nextButtonTapAction(number: String) {
        AuthManager.shared.startAuth(phoneNumber: number) { [weak self] success in
            guard success else { return }
            DispatchQueue.main.async {
                let confirmSignUpVC = ConfirmSignUpScreenViewController()
                self?.navigationController?.pushViewController(confirmSignUpVC, animated: true)
            }
        }
    }
}
