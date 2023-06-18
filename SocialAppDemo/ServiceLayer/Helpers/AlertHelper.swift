//
//  AlertHelper.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 17.06.2023.
//

import UIKit

protocol AlertHelperProtocol {
    func showUserDetails(fullname: String?, birthday: String?, hometown: String?, isMale: Bool?) -> UIAlertController
}

class AlertHelper: AlertHelperProtocol {

    static let shared = AlertHelper()

    private init() {
    }

    func showUserDetails(
        fullname: String?,
        birthday: String?,
        hometown: String?,
        isMale: Bool?
    ) -> UIAlertController {

        let fullname: String = fullname ?? "unknown".localizable
        let birthday: String = birthday ?? "unknown".localizable
        let hometown: String = hometown ?? "unknown".localizable
        let gender: String
        if isMale == nil {
            gender = "unknown".localizable
        } else {
            gender = isMale! ? "male".localizable : "female".localizable
        }

        let message = "\(fullname)\n" + "gender".localizable + ": " + "\(gender)\n" + "birthday".localizable + ": " + "\(birthday)\n"
        + "hometown".localizable + ": " + "\(hometown)"

        let alertController = UIAlertController(title: "detailed_information".localizable, message: message, preferredStyle: .alert)


        let cancelAction = UIAlertAction(title: "close".localizable, style: .cancel)
        alertController.addAction(cancelAction)

        return alertController
    }

}
