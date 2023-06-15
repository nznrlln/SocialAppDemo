//
//  UIView+Extention.swift
//  Navigation
//
//  Created by Нияз Нуруллин on 12.06.2022.
//

import UIKit

extension UIView {
    static var identifier: String {
        String(describing: self)
    }

    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}
