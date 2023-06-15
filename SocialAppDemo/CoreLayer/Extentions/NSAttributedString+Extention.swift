//
//  NSAttributedString+Extention.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 02.06.2023.
//

import Foundation

extension NSAttributedString {

    static func makeHyperlink(
        for urlPath: String,
        in string: String,
        as substring: String,
        with attributes: [NSAttributedString.Key: NSObject]
    ) -> NSAttributedString {
        let nsString = NSString(string: string)
        let substringRange = nsString.range(of: substring)
        let attributedString = NSMutableAttributedString(string: string, attributes: attributes)
        attributedString.addAttribute(.link, value: urlPath, range: substringRange)

        return attributedString
    }
}
