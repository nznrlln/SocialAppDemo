//
//  MainScreenModel.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 27.04.2023.
//

import Foundation

protocol MainScreenModelDelegate: AnyObject {
    func modelUpdatedUsers()
    func modelUpdatedPosts()
}

class MainScreenModel {

    weak var delegate: MainScreenModelDelegate?

    var usersCollection = [UserModel]() {
        didSet {
            delegate?.modelUpdatedUsers()
        }
    }

    var postsCollection = [String?: [PostModel]]() {
        didSet {
            delegate?.modelUpdatedPosts()
        }
    }

    var postsDates: [String] = []

    func getModelData() {
        DispatchQueue.global().async { [weak self] in
            self?.getUsers() {
                self?.getPosts()
            }
        }
    }

    private func getUsers(completion: @escaping () -> Void) {
        FirestoreManager.shared.getAllUsers { [weak self] users in
            guard let users = users else { return }
            self?.usersCollection = users
            completion()
        }
    }

    private func getPosts() {
        FirestoreManager.shared.getAllPosts { [weak self] postColletion, postDates in
            guard let postColletion = postColletion else { return }
            guard let dates = postDates else { return }

            let sortedDates = dates.sorted {
                $0 > $1
            }
            self?.postsDates = sortedDates

            let dict = Dictionary(grouping: postColletion) { $0.creationDate }
            self?.postsCollection = dict
        }
    }
}
