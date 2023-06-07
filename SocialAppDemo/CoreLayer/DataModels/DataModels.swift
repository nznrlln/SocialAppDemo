//
//  DataModels.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 28.04.2023.
//

//import Foundation
import UIKit

class UserModel {
    var userUID: String!
    var nickname: String?
    var status: String?
    var avatar: UIImage?

    var postsCount: Int?
    var followingsCount: Int?
    var followersCount: Int?
    var fullname: String?
    var birthday: Date?
    var hometown: String?
    var isMale: Bool?
}


class PostModel {
    var postUID: String!
    var authorUID: String!

    var creationDate: String?
    var commentsCount: Int?
    var likesCount: Int?
    var postImage: UIImage?
    var postText: String?
}
