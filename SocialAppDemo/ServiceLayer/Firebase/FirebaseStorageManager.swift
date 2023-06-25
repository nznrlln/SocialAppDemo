//
//  FirebaseStorageManager.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 23.04.2023.
//

import FirebaseStorage
import UIKit

protocol FirebaseStorageManagerProtocol {
    func getImages(number: Int, completion: @escaping ([UIImage]?) -> Void)
    func getAllImages(completion: @escaping ([UIImage]?) -> Void)
    func getPhotoCollectionList(completion: @escaping ([StorageReference]?) -> Void)
    func getImage(ref imageRef: StorageReference, completion: @escaping (UIImage?) -> Void)
    func getImage(ref imageURL: String, completion: @escaping (UIImage?) -> Void)
}

final class FirebaseStorageManager: FirebaseStorageManagerProtocol {

    static let shared = FirebaseStorageManager()

    private let storage = Storage.storage()
    private let storageRef = Storage.storage().reference()

    let backgroundQueue = DispatchQueue(label: "background_queue", qos: .background)

    private init() {}

    func getImages(number: Int, completion: @escaping ([UIImage]?) -> Void) {
        getPhotoCollectionList { [weak self] imageRefs in
            guard let imageRefs = imageRefs else { completion(nil); return }
            let limitedRefs = Array(imageRefs.prefix(number))
            let imagesCount = limitedRefs.count
            var images = [UIImage]()

            for ref in limitedRefs {
                self?.getImage(ref: ref) { image in
                    guard let image = image else { return }
                    images.append(image)

                    if images.count == imagesCount {
                        completion(images)
                    }
                }
            }
        }
    }

    func getAllImages(completion: @escaping ([UIImage]?) -> Void) {
        getPhotoCollectionList { [weak self] imageRefs in
            guard let imageRefs = imageRefs else { completion(nil); return }
            let imagesCount = imageRefs.count
            var images = [UIImage]()

            for ref in imageRefs {
                self?.getImage(ref: ref) { image in
                    guard let image = image else { return }
                    images.append(image)

                    if images.count == imagesCount {
                        completion(images)
                    }
                }
            }
        }
    }

    func getPhotoCollectionList(completion: @escaping ([StorageReference]?) -> Void) {
        // we'll create a Reference to the folder
        let folderRef = storageRef.child("photoCollection")

        // Now we get the references of these images
        folderRef.listAll { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }

            guard let result = result else { completion(nil); return }
            completion(result.items)
        }
    }

    // getting image with Firebase Storage Reference
    func getImage(ref imageRef: StorageReference, completion: @escaping (UIImage?) -> Void) {
        imageRef.getData(maxSize: 1024*1024) { data, error in
            if let error = error {
                debugPrint(error.localizedDescription)
                completion(nil)
            }

            guard let imageData = data else { completion(nil); return }
            let image = UIImage(data: imageData)
            completion(image)
        }
    }

    // getting image with Google Cloud Storage URI - example: "gs://<your-firebase-storage-bucket>/images/stars.jpg"
    // such urls are saved in Firestore for avatars and posts
    func getImage(ref imageURL: String, completion: @escaping (UIImage?) -> Void) {
        // Create a reference from a Google Cloud Storage URI
        let imageRef = storage.reference(forURL: imageURL)
        imageRef.getData(maxSize: 4 * 1024 * 1024) { data, error in
            if let error = error {
                debugPrint(error.localizedDescription)
                completion(nil)
            }

            guard let imageData = data else { completion(nil); return }
            let image = UIImage(data: imageData)
            completion(image)
        }
    }
    
}
      
