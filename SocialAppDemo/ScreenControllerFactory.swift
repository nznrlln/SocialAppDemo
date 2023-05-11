//
//  ScreenControllerFactory.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 30.04.2023.
//

import Foundation
import UIKit

//protocol ScreenControllerFactoryProtocol: AnyObject {
//    func createScreen()
//}

final class ScreenControllerFactory {

    enum Flow {
        case mainScreen
        case profileScreen
        case savedScreen
    }

    let navController: UINavigationController = UINavigationController()
    let flow: Flow

    let profileUID: String?


    init(flow: Flow, profileUID: String?) {
        self.flow = flow
        self.profileUID = profileUID

        createModule()
    }

    private func createModule() {
        switch flow {

        case .mainScreen:
            let model = MainScreenModel()
            let mainView = MainScreenView()
            let controller = MainScreenViewController(model: model, mainView: mainView)

            navController.tabBarItem.title = "main".localizable
            navController.tabBarItem.image = UIImage(systemName: "house")
            navController.setViewControllers([controller], animated: true)

        case .profileScreen:
            let model = ProfileScreenDataModel(profileUID: self.profileUID)
            let mainView = ProfileScreenView()
            let controller = ProfileScreenViewController(model: model, mainView: mainView)

            navController.tabBarItem.title = "profile".localizable
            navController.tabBarItem.image = UIImage(systemName: "person.crop.circle")
            navController.setViewControllers([controller], animated: true)

        case .savedScreen:
            let mainView = SavedScreenView()
            let controller = SavedScreenViewController(mainView: mainView)

            navController.tabBarItem.title = "saved".localizable
            navController.tabBarItem.image = UIImage(systemName: "bookmark")
            navController.setViewControllers([controller], animated: true)
        }
    }

}


extension ScreenControllerFactory {
    
    convenience init(flow: Flow) {
        self.init(flow: flow, profileUID: nil)
    }

    convenience init(profileUID: String?) {
        self.init(flow: .profileScreen, profileUID: profileUID)
    }



}
