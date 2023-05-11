//
//  MainTabBarController.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 21.03.2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    private let mainScreen = ScreenControllerFactory(flow: .mainScreen)
    private let profileScreen = ScreenControllerFactory(flow: .profileScreen)
    private let savedScreen = ScreenControllerFactory(flow: .savedScreen)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupControllers()
    }

    private func setupControllers() {

        viewControllers = [
            mainScreen.navController,
            profileScreen.navController,
            savedScreen.navController
        ]

        tabBar.backgroundColor = Palette.mainBackground
        tabBar.tintColor = Palette.mainAccent
    }


}
