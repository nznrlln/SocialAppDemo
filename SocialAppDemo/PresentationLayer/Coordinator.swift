//
//  Coordinator.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 10.06.2023.
//

import UIKit

protocol Coordinator: AnyObject {
    // coordinator needs a navController to control
    var navigationController: UINavigationController { get set }

    // coordinator needs a starting screen which he will push onto navController
    func start()
}
