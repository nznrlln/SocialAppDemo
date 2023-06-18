//
//  GeneralContentCoordinator.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 15.06.2023.
//

import UIKit

protocol GeneralContentCoordinator: Coordinator {
    func openPost(post: PostModel, author: UserModel)
    func openProfile(profileUID: String?)
    func openPhotos()
}
