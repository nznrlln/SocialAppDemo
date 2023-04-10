//
//  MainTabBarController.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 21.03.2023.
//

import UIKit

class MainTabBarController: UITabBarController {

//    private let vc1 = WelcomeScreenViewController()
//    private let vc2 = LogInScreenViewController()
//    private let vc3 = SignUpScreenViewController()
//    private let vc4 = ConfirmSignUpScreenViewController()
    private let mainVC: MainScreenViewController = {
        let vc = MainScreenViewController()
        vc.title = "Main".localizable
        vc.tabBarItem.image = UIImage(systemName: "house")

        return vc
    }()

    private let profileVC: ProfileScreenViewController = {
        let vc = ProfileScreenViewController()
        vc.title = "Profile".localizable
        vc.tabBarItem.image = UIImage(systemName: "person.crop.circle")

        return vc
    }()

    private let savedVC: SavedScreenViewController = {
        let vc = SavedScreenViewController()
        vc.title = "Saved".localizable
        vc.tabBarItem.image = UIImage(systemName: "bookmark")

        return vc
    }()
    private let vc6 = PostScreenViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupControllers()
    }

    private func setupControllers() {
        viewControllers = [
//            vc1,
//            vc2,
//            vc3,
//            vc4,
            mainVC,
            profileVC,
            savedVC,
            vc6
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
