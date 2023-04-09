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
    private let mainVC = MainScreenViewController()
    private let profileVC = ProfileScreenViewController()
    private let vc6 = PostScreenViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupControllers()
    }

    private func setupControllers() {
        mainVC.title = "Main".localizable
        mainVC.tabBarItem.image = UIImage(systemName: "house")

        profileVC.title = "Profile".localizable
        profileVC.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        viewControllers = [
//            vc1,
//            vc2,
//            vc3,
//            vc4,
            mainVC,
            profileVC,
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
