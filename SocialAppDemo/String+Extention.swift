//
//  String+Extention.swift
//  Navigation
//
//  Created by Нияз Нуруллин on 06.11.2022.
//

import Foundation

extension String {
    var localizable: String {
        return NSLocalizedString(self, comment: "")
    }

    func localizedPlural(arg: Int) -> String {
        let formatString = NSLocalizedString(self, comment: "")

        return Self.localizedStringWithFormat(formatString, arg as CVarArg)
    }
}
