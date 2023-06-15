//
//  CoreDataHelper.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 11.05.2023.
//

import UIKit

class CoreDataHelper {

    static let shared = CoreDataHelper()

    private init() {}

    func getModels(from savedPost: SavedPostCoreData) -> (user: UserModel, post: PostModel) {
        let user = UserModel()
        let post = PostModel()

        user.userUID = savedPost.authorUID
        user.nickname = savedPost.authorNickname
        user.status = savedPost.authorStatus
        user.avatar = UIImage(data: savedPost.authorAvatar ?? Data())

        post.postUID = savedPost.postUID
        post.creationDate = savedPost.postCreationDate
        post.postText = savedPost.postText
        post.postImage = UIImage(data: savedPost.postImage ?? Data())

        return (user, post)
    }
}
