//
//  Pallete.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 19.03.2023.
//

import UIKit

enum Palette {
    static let mainBackground = UIColor.systemBackground
    static let secondBackground = UIColor(named: "SecondBackgroundColor")
    static let mainAccent = UIColor(named: "MainAccentColor")

    static let darkButton = UIColor(named: "DarkButtonColor") ?? .systemGray

    static let blackAndWhite = UIColor.createColor(lightMode: .black, darkMode: .white)

    static let secondaryText = UIColor(named: "SecondaryTextColor") ?? .systemGray5

    static let thirdText = UIColor(named: "ThirdTextColor") ?? .systemGray6
}
