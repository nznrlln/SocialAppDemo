//
//  FirestoreDatabaseManager.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 27.04.2023.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage


struct FirestoreRefs {
    static let devUsers = "dev/dev/users"
    static let devPosts = "dev/dev/posts"

}

class FirestoreManager {

    static let shared = FirestoreManager()

    private let db: Firestore = {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings

        let db = Firestore.firestore()
        return db
    }()

    private lazy var dbUsers = db.collection(FirestoreRefs.devUsers)
    private lazy var dbPosts = db.collection(FirestoreRefs.devPosts)

    private init() {}

    func getAllUsers(completion: @escaping ([UserModel]?) -> Void) {
        dbUsers.getDocuments { [weak self] snapshot, error in
            if let error = error {
                debugPrint(error.localizedDescription)
            }

            guard let snapshot = snapshot else { return }
            let snapshotCount = snapshot.documents.count
            var users = [UserModel]()

            snapshot.documents.forEach { doc in
                let dataDict = doc.data()
                self?.getUserFromData(userData: dataDict) { userModel in
                    guard let user = userModel else { assertionFailure("no user"); return}
                    users.append(user)

                    if users.count == snapshotCount {
                        completion(users)
                    }
                }
            }
        }
    }

    func getUserFromData(userData: [String : Any], completion: @escaping (UserModel?) -> Void ) {
        FirebaseStorageManager.shared.getImage(ref: userData["avatar"] as! String) { image in
            Task {
                guard let userUID = userData["uid"] as? String else { completion(nil); return }

                let user = UserModel()
                user.avatar = image
                user.userUID = userUID
                user.nickname = userData["nickname"] as? String
                user.status = userData["status"] as? String
                user.followingsCount = userData["followings_count"] as? Int
                user.followersCount = userData["followers_count"] as? Int
                user.fullname = userData["fullname"] as? String
                user.birthday = userData["birthday"] as? Date
                user.hometown = userData["hometown"] as? String
                user.isMale = userData["is_male"] as? Bool

                user.postsCount = await self.getUserPostsCount(userUID: user.userUID)

                completion(user)
            }
        }
    }

    // get user data from firestore with users field "uid"
    func getUserData(userUID: String, completion: @escaping (UserModel?) -> Void ) {
        dbUsers.document(userUID).getDocument { [weak self] snapshot, error in
            if let error = error {
                debugPrint(error.localizedDescription)
            }

            guard let snapshot = snapshot else { return }
            guard let dataDict = snapshot.data() else { return }

            self?.getUserFromData(userData: dataDict) { userModel in
                guard let user = userModel else { assertionFailure("no user"); return }

                completion(user)
            }
        }

    }

    func getMainUserData(completion: @escaping (UserModel?) -> Void ) {
        dbUsers.whereField("nickname", isEqualTo: "mainUser").getDocuments { [weak self] snapshot, error in
            if let error = error {
                debugPrint(error.localizedDescription)
            }

            guard let snapshot = snapshot else { return }
            guard let dataDict = snapshot.documents.first?.data() else { return }

            self?.getUserFromData(userData: dataDict) { userModel in
                guard let user = userModel else { assertionFailure("no user"); return }

                completion(user)
            }
        }

    }

    // get the number of posts where a specific user is an author
    func getUserPostsCount(userUID: String) async -> Int? {
        let query = dbPosts.whereField("author_uid", isEqualTo: userUID)
        let countQuery = query.count

        do {
            let snapshot = try await countQuery.getAggregation(source: .server)
            let count = Int(truncating: snapshot.count)
            return count
        } catch {
            debugPrint(error.localizedDescription)
            return nil
        }
    }

    // get data for all posts in firestore
    func getAllPosts(completion: @escaping ([PostModel]?, [String]?) -> Void) {
        dbPosts.limit(to: 20).order(by: "creation_date", descending: true).getDocuments { [weak self] snapshot, error in
            if let error = error {
                debugPrint(error.localizedDescription)
            }

            guard let snapshot = snapshot else { completion(nil, nil); return }
            let snapshotCount = snapshot.documents.count
            var posts = [PostModel]()
            var postsDates = [String]()

            snapshot.documents.forEach { doc in
                let dataDict = doc.data()
                self?.getPostFromData(postData: dataDict) { postModel in
                    guard let post = postModel else { assertionFailure("no post"); return }
                    posts.append(post)

                    if let date = post.creationDate {
                        if !postsDates.contains(date) {
                            postsDates.append(date)
                        }
                    }

                    if posts.count == snapshotCount {
                        completion(posts, postsDates)
                    }

                }
            }
        }
    }

    func getUserPosts(userUID: String, completion: @escaping ([PostModel]?, [String]?) -> Void) {
        dbPosts.whereField("author_uid", isEqualTo: userUID).order(by: "creation_date", descending: true).getDocuments { [weak self] snapshot, error in
            if let error = error {
                debugPrint(error.localizedDescription)
            }

            guard let snapshot = snapshot else { completion(nil, nil); return }
            let snapshotCount = snapshot.documents.count
            var posts = [PostModel]()
            var postsDates = [String]()

            snapshot.documents.forEach { doc in
                let dataDict = doc.data()
                self?.getPostFromData(postData: dataDict) { postModel in
                    guard let post = postModel else { assertionFailure("no post"); return }
                    posts.append(post)

                    if let date = post.creationDate {
                        if !postsDates.contains(date) {
                            postsDates.append(date)
                        }
                    }

                    if posts.count == snapshotCount {
                        completion(posts, postsDates)
                    }

                }
            }
        }
    }

    private func getPostFromData(postData: [String : Any], completion: @escaping (PostModel?) -> Void ) {
        let imageRef = postData["post_image"] as! String
        FirebaseStorageManager.shared.getImage(ref: imageRef) { image in
            Task {
//                guard let image = image else { completion(nil); return }
                guard let postUID = postData["post_uid"] as? String else { completion(nil); return }
                guard let authorUID = postData["author_uid"] as? String else { completion(nil); return }

                let post = PostModel()
                post.postImage = image
                post.postUID = postUID
                post.authorUID = authorUID
                post.commentsCount = postData["comments_count"] as? Int
                post.likesCount = postData["likes_count"] as? Int
                post.postText = postData["post_text"] as? String
                post.creationDate = DateHelper.shared.getPostDate(timestamp:  postData["creation_date"] as! Timestamp)

                completion(post)
            }
        }
    }



}
