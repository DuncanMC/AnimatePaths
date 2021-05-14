//
//  UIView+borderColor.swift
//  AnimatePaths
//
//  Created by Duncan Champney on 5/13/21.
//

import Foundation
import UIKit

extension UIView {
    @objc var borderColor: UIColor? {
        get {
            return layer.borderColor.map { UIColor(cgColor: $0) }
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
