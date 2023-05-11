//
//  CoreDataManager.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 12.03.2023.
//

import Foundation
import CoreData

final class CoreDataManager {

    static let shared = CoreDataManager()

    lazy var mainContext = persistentContainer.viewContext

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SocialAppDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        container.viewContext.automaticallyMergesChangesFromParent = true

        return container
    }()

    private func saveMainContext() {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func addPost(post: PostModel, author: UserModel) {
        let exist = postCheck(postUID: post.postUID)
        if !exist {
            persistentContainer.performBackgroundTask { context in
                let newPost = SavedPostCoreData(context: context)
                newPost.postUID = post.postUID
                newPost.postText = post.postText
                newPost.postCreationDate = post.creationDate
                if let postImageData = post.postImage?.pngData() {
                    newPost.postImage = postImageData
                }

                newPost.authorUID = author.userUID
                newPost.authorNickname = author.nickname
                newPost.authorStatus = author.status
                if let avatarImageData = author.avatar?.pngData() {
                    newPost.authorAvatar = avatarImageData
                }

                do {
                    try context.save()
                    debugPrint("Post added")
                } catch {
                    debugPrint("🎲 CoreDataError: \(error)")
                }
            }
        }
    }

    func deletePost(post: SavedPostCoreData) {
        mainContext.delete(post)
        saveMainContext()
    }

    private func postCheck(postUID: String) -> Bool {
        let request = SavedPostCoreData.fetchRequest()

        do {
            if let _ = try mainContext.fetch(request).first(where: { $0.postUID == postUID }) {
                return true
            } else {
                return false
            }
        } catch {
            debugPrint("🎲 CoreDataError: \(error)")
            return false
        }
    }

}

