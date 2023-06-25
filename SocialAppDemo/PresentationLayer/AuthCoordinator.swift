//
//  AuthCoordinator.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 11.06.2023.
//

import UIKit

// coordinator for Authentication flow
final class AuthCoordinator: Coordinator {
    // navController for authentication flow
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.tintColor = Palette.darkButton
    }

    // coordinating starting screen for navController
    func start() {
        let welcomeVC = WelcomeScreenViewController()
        welcomeVC.coordinator = self
        navigationController.pushViewController(welcomeVC, animated: true)
    }

    // coordinating to open next screen (to sign in/up by entering phone)
    func openSignInScreen() {
        let signInVC = SignInScreenViewController()
        signInVC.coordinator = self
        navigationController.pushViewController(signInVC, animated: true)
    }

    // coordinating to open next screen (to confirm sign in/up for entered phone)
    func openConfirmSignInScreen(phoneNumber: String) {
        let confirmSignInVC = ConfirmSignInScreenViewController(accountPhoneNumber: phoneNumber)
        confirmSignInVC.coordinator = self
        navigationController.pushViewController(confirmSignInVC, animated: true)
    }

    // coordinating to open app's general content (after seccessful authentication)
    func openGeneralContent() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate
          else { return }
        let tabbarVC = MainTabBarController()

        sceneDelegate.window?.rootViewController = tabbarVC
        sceneDelegate.authCoordinator = nil
    }


}
