//
//  MainTabBarController.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 21.03.2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    let mainCoordinator = MainCoordinator(navigationController: UINavigationController())
    let profileCoordinator = ProfileCoordinator(navigationController: UINavigationController())
    let savedCoordinator = SavedCoordinator(navigationController: UINavigationController())

    private let mainScreen = ScreenControllerFactory(flow: .mainScreen)
    private let profileScreen = ScreenControllerFactory(flow: .profileScreen)
    private let savedScreen = ScreenControllerFactory(flow: .savedScreen)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupControllers()
    }

    private func setupControllers() {
        mainCoordinator.start()
        profileCoordinator.start()
        savedCoordinator.start()

        viewControllers = [
            mainCoordinator.navigationController,
            profileCoordinator.navigationController,
            savedCoordinator.navigationController
        ]

        tabBar.backgroundColor = Palette.mainBackground
        tabBar.tintColor = Palette.mainAccent
    }


}
