//
//  CustomUIButton.swift
//  Navigation
//
//  Created by Нияз Нуруллин on 23.07.2022.
//

import Foundation
import UIKit

class CustomUIButton: UIButton {

    var customButtonTapAction: (() -> Void)?

    init(title: String, font: UIFont, titleColor: UIColor?, backgroundColor: UIColor?, state:UIControl.State) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: state)
        self.titleLabel?.font = font
        self.setTitleColor(titleColor, for: state)
        self.backgroundColor = backgroundColor
        self.addTarget(self, action: #selector(customButtonTap), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func customButtonTap() {
        customButtonTapAction?()
    }

}
