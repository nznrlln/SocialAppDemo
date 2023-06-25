//
//  PostScreenModel.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 03.05.2023.
//

import Foundation

final class PostScreenModel {

    let post: PostModel
    let author: UserModel

    init(post: PostModel, author: UserModel) {
        self.post = post
        self.author = author
    }
}
