//
//  ProfileCoordinator.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 11.06.2023.
//

import UIKit

final class ProfileCoordinator: GeneralContentCoordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.tintColor = Palette.darkButton
    }

    func start() {
        let model = ProfileScreenModel(profileUID: nil)
        let controller = ProfileScreenViewController(model: model)
        controller.coordinator = self

        navigationController.tabBarItem.title = "profile".localizable
        navigationController.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        navigationController.setViewControllers([controller], animated: true)
    }

    func openPost(post: PostModel, author: UserModel) {
        let model = PostScreenModel(post: post, author: author)
        let controller = PostScreenViewController(model: model)
        controller.coordinator = self

        self.navigationController.pushViewController(controller, animated: true)
    }

    func openProfile(profileUID: String?) {
        let model = ProfileScreenModel(profileUID: profileUID)
        let controller = ProfileScreenViewController(model: model)
        controller.coordinator = self

        self.navigationController.pushViewController(controller, animated: true)
    }

    func openPhotos() {
        let model = PhotosScreenModel()
        let controller = PhotosScreenViewController(model: model)

        self.navigationController.pushViewController(controller, animated: true)
    }


}
