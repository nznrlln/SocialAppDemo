//
//  DateHelper.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 02.05.2023.
//

import Foundation
import FirebaseFirestore

protocol DateHelperProtocol {
    func getPostDate(timestamp: Timestamp) -> String
    func getBirthdayDate(timestamp: Timestamp) -> String
}

class DateHelper: DateHelperProtocol {

    static let shared = DateHelper()

    private let dateFormatter = DateFormatter()

    private init() {}

    func getPostDate(timestamp: Timestamp) -> String {
        let date = Date(timeIntervalSince1970: Double(timestamp.seconds))

        dateFormatter.dateFormat = "dd.MM.yyyy"
        let text = dateFormatter.string(from: date)

        return text
    }

    func getBirthdayDate(timestamp: Timestamp) -> String {
        let date = Date(timeIntervalSince1970: Double(timestamp.seconds))

        dateFormatter.dateFormat = "dd MMMM yyyy"
        let text = dateFormatter.string(from: date)

        return text
    }
}

