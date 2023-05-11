//
//  Observer.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 30.04.2023.
//

//import Foundation
//
//// MARK: - Protocol
//protocol Publisher {
//    func notify()
//}
//protocol Subscriber {
//    func update(subject : Bloger )
//}
//
////Fix retain cycle
//struct WeakSubscriber {
//    weak var value : Subscriber?
//}
//
//class Bloger {
//
//    private lazy var subscribers : [WeakSubscriber] = [] // Массив с подписчиками
//
//    var counter : Int = 0
//    var lastVideo = ""
//
//    func subscribe(_ subscriber: Subscriber) {
//        print("subscribed")
//        subscribers.append(WeakSubscriber(value: subscriber))
//    }
//
//    func unsubscribe(_ subscriber: Subscriber) {
//        subscribers.removeAll(where: { $0.value === subscriber })
//        print("unsubscribed")
//    }
//
//    func notify() {
//        subscribers.forEach { $0.value?.update(subject: self)
//        }
//    }
//
//    func releaseVideo() {
//        counter += 1
//        lastVideo = "video" + "\(counter)"
//        notify()
//        print("released!")
//    }
//
//}
