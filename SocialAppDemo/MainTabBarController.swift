//
//  MainTabBarController.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 21.03.2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    private let mainVC: MainScreenViewController = {
        let vc = MainScreenViewController()
        vc.title = "main".localizable
        vc.tabBarItem.image = UIImage(systemName: "house")

        return vc
    }()

    private let profileVC: ProfileScreenViewController = {
        let vc = ProfileScreenViewController()
        vc.title = "profile".localizable
        vc.tabBarItem.image = UIImage(systemName: "person.crop.circle")

        return vc
    }()

    private let savedVC: SavedScreenViewController = {
        let vc = SavedScreenViewController()
        vc.title = "saved".localizable
        vc.tabBarItem.image = UIImage(systemName: "bookmark")

        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupControllers()
    }

    private func setupControllers() {
        let mainNC = UINavigationController(rootViewController: mainVC)

        let profileNC = UINavigationController(rootViewController: profileVC)
        profileNC.navigationBar.isHidden = true

        let savedNC = UINavigationController(rootViewController: savedVC)
        savedNC.navigationBar.isHidden = true

        viewControllers = [
            mainNC,
            profileNC,
            savedNC
        ]

        tabBar.backgroundColor = Palette.mainBackground
        tabBar.tintColor = Palette.mainAccent
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
