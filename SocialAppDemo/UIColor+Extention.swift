//
//  UIColor+Extention.swift
//  Navigation
//
//  Created by Нияз Нуруллин on 15.11.2022.
//

import UIKit

extension UIColor {

    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {

        guard #available(iOS 13.0, *) else {
            return lightMode
        }

        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }
}
