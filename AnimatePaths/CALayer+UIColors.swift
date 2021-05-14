//
//  CALayer+UIColors.swift
//  AnimatePaths
//
//  Created by Duncan Champney on 5/13/21.
//

//
//  CALayer+ColorExtensions.swift
//  TabBarController
//
//  Created by Duncan Champney on 3/31/21.
//

import UIKit
import CoreGraphics
import Foundation

extension CALayer {
    @objc var backgroundUIColor: UIColor? {
        get { return self.backgroundColor.map { UIColor(cgColor: $0) } }
        set { self.backgroundColor = newValue?.cgColor }
    }
    @objc var borderUIColor: UIColor? {
        get { return self.borderColor.map { UIColor(cgColor: $0) } }
        set { self.borderColor = newValue?.cgColor }
    }
}

