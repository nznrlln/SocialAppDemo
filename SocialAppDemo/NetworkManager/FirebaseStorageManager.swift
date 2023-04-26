//
//  FirebaseStorageManager.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 23.04.2023.
//

import Foundation
import FirebaseStorage
import UIKit

class FirebaseStorageManager {

    static let shared = FirebaseStorageManager()

    private let storageRef = Storage.storage().reference()


    private init() {}

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
    
}
      
