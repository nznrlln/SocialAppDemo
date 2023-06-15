//
//  ProfileScreenDataModel.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 23.04.2023.
//

import UIKit

protocol ProfileScreenModelDelegate: AnyObject {
    func modelUpdatedProfileData()
    func modelUpdatedPhotos()
    func modelUpdatedPosts()
}

class ProfileScreenModel {

    weak var delegate: ProfileScreenModelDelegate?

    var profileUID: String?

    var profileData = UserModel() {
        didSet {
            delegate?.modelUpdatedProfileData()
        }
    }

    var userPhotos = [UIImage]() {
        didSet {
            delegate?.modelUpdatedPhotos()
        }
    }

    var userPosts = [String?: [PostModel]]() {
        didSet {
            delegate?.modelUpdatedPosts()
        }
    }

    var postsDates: [String] = []


    init(profileUID: String?) {
        self.profileUID = profileUID

        getModelData()
    }

    func getModelData() {
        DispatchQueue.global().async { [weak self] in
            self?.getUserProfile() {
                self?.getUserPosts()
            }
            self?.getUserPhotoCollection()
        }
        
    }

    func getUserProfile(completion: @escaping () -> Void) {
        if let uid = profileUID {
            FirestoreManager.shared.getUserData(userUID: uid) { [weak self] model in
                guard let model = model else { assertionFailure(); return }

                self?.profileData = model
                self?.profileUID = model.userUID
                completion()
            }
        } else if profileUID == nil {
            FirestoreManager.shared.getMainUserData { [weak self] model in
                guard let model = model else { assertionFailure(); return }

                self?.profileData = model
                self?.profileUID = model.userUID
                completion()
            }
        }
    }

    func getUserPhotoCollection() {
        FirebaseStorageManager.shared.getImages(number: 6) { [weak self] images in
            guard let images = images else { assertionFailure(); return }

            self?.userPhotos = images
        }
    }

    func getUserPosts() {
        guard let profileUID = profileUID else { return }

        FirestoreManager.shared.getUserPosts(userUID: profileUID) { [weak self] postColletion, postDates in
            guard let postColletion = postColletion else { assertionFailure(); return }
            guard let dates = postDates else { assertionFailure(); return }

            let sortedDates = dates.sorted {
                $0 > $1
            }
            self?.postsDates = sortedDates

            let dict = Dictionary(grouping: postColletion) { $0.creationDate }
            self?.userPosts = dict

        }
    }
}
