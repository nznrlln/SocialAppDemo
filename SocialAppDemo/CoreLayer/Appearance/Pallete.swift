//
//  Pallete.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 19.03.2023.
//

import UIKit

struct Palette {
    static var mainBackground = UIColor.systemBackground
    static var secondBackground = UIColor(named: "SecondBackgroundColor")
    static var mainAccent = UIColor(named: "MainAccentColor")

    static var darkButton = UIColor(named: "DarkButtonColor") ?? .systemGray

    static var blackAndWhite = UIColor.createColor(lightMode: .black, darkMode: .white)

    static var secondaryText = UIColor(named: "SecondaryTextColor") ?? .systemGray5

    static var thirdText = UIColor(named: "ThirdTextColor") ?? .systemGray6
}
