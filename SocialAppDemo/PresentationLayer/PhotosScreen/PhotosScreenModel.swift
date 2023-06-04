//
//  PhotosScreenModel.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 21.05.2023.
//

import Foundation
import UIKit

protocol PhotosScreenModelDelegate {
    func modelUpdatedPhotos()
}

class PhotosScreenModel {

    var delegate: PhotosScreenModelDelegate?
    
    var userPhotos = [UIImage]() {
        didSet {
            delegate?.modelUpdatedPhotos()
        }
    }

    func getModelData() {
        FirebaseStorageManager.shared.getAllImages { [weak self] images in
            guard let images = images else { assertionFailure(); return }

            self?.userPhotos = images
        }


    }
}
