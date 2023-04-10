//
//  UILabel+Extention.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 09.04.2023.
//

import UIKit

extension UILabel {

    func setTitleWithSFImage(iconName: String, tintColor: UIColor) {
        // Create Attachment
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: iconName)?.withTintColor(tintColor)

        // Set bound to reposition
        let imageOffsetY: CGFloat = -5.0
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)

        // Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)

        // Initialize mutable string
        let completeText = NSMutableAttributedString(string: "")

        // Add image to mutable string
        completeText.append(attachmentString)

        // Add your text to mutable string
        self.textAlignment = .center
        self.attributedText = completeText
    }

}
