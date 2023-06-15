//
//  SignUpScreenViewController.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 25.03.2023.
//

import UIKit
import SnapKit

class SignInScreenViewController: UIViewController {

    weak var coordinator: AuthCoordinator?

    private lazy var mainView: SignInScreenView = {
        let view = SignInScreenView()
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
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    

    

}

// MARK: - SignUpScreenViewDelegate
extension SignInScreenViewController: SignInScreenViewDelegate {
    func nextButtonTapAction(number: String) {
        AuthManager.shared.startAuth(phoneNumber: number) { [weak self] success in
            guard success else { return }
            DispatchQueue.main.async {
                self?.coordinator?.openConfirmSignInScreen(phoneNumber: number)
            }
        }
    }
}
