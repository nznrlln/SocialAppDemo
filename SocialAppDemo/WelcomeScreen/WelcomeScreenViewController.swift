//
//  WelcomeScreenViewController.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 19.03.2023.
//

import UIKit
import SnapKit

class WelcomeScreenViewController: UIViewController {

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
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }

}

// MARK: - WelcomeScreenViewDelegate
extension WelcomeScreenViewController: WelcomeScreenViewDelegate {
    func signUpButtonTapAction() {
        let signUpVC = SignUpScreenViewController()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }

    func logInButtonTapAction() {
        let logInVC = LogInScreenViewController()
        self.navigationController?.pushViewController(logInVC, animated: true)    }


}
