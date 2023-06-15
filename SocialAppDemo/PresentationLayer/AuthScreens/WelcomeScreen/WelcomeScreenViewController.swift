//
//  WelcomeScreenViewController.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 19.03.2023.
//

import UIKit
import SnapKit

class WelcomeScreenViewController: UIViewController {

    weak var coordinator: AuthCoordinator?

    private lazy var mainView: WelcomeScreenView = {
        let view = WelcomeScreenView()
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

// MARK: - WelcomeScreenViewDelegate
extension WelcomeScreenViewController: WelcomeScreenViewDelegate {
    func signUpButtonTapAction() {
//        let signInVC = SignInScreenViewController()
//        self.navigationController?.pushViewController(signInVC, animated: true)
        self.coordinator?.openSignInScreen()

    }
}
