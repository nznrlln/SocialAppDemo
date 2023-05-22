//
//  CustomSaveButton.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 17.05.2023.
//

import Foundation
import UIKit

class CustomSaveButton: UIButton {

    private let savedImage = UIImage(
        systemName: "bookmark.fill",
        withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 14,
            weight: .regular,
            scale: .large
        )
    )
    private let unsavedImage = UIImage(
        systemName: "bookmark",
        withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 14,
            weight: .regular,
            scale: .large
        )
    )
    var isSaved: Bool = false {
        didSet {
            if isSaved == true {
                self.setImage(savedImage, for: .normal)
            } else {
                self.setImage(unsavedImage, for: .normal)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setImage(UIImage(systemName: "bookmark"), for: .normal)
        self.tintColor = Palette.mainAccent
        self.addTarget(self, action: #selector(customSaveButtonTap), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func toogle() {
        isSaved = !isSaved
    }

    @objc private func customSaveButtonTap() {
        toogle()
        debugPrint("Saved: \(isSaved)")
    }

}
