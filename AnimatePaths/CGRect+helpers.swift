//
//  CGRect+helpers.swift
//  AnimatePaths
//
//  Created by Duncan Champney on 5/13/21.
//

import Foundation
import CoreGraphics

extension CGRect {
    var center:         CGPoint     { return CGPoint(x: midX, y: midY)}

    var topLeft:        CGPoint     { return origin }
    var topRight:       CGPoint     { return CGPoint(x: maxX, y: minY)}
    var bottomRight:    CGPoint     { return CGPoint(x: maxX, y: maxY) }
    var bottomLeft:     CGPoint     { return CGPoint(x: minX, y: maxY) }
    var corners:        [CGPoint]   { return [topLeft, topRight, bottomRight, bottomLeft] }

    var middleTop:      CGPoint     { return CGPoint(x: midX, y: minY) }
    var middleRight:    CGPoint     { return CGPoint(x: maxX, y: midY) }
    var middleBottom:   CGPoint     { return CGPoint(x: midX, y: maxY) }
    var middleLeft:     CGPoint     { return CGPoint(x: minX, y: midY) }
    var centerpoints:   [CGPoint]   { return [middleTop, middleRight, middleBottom, middleLeft] }

    init(center: CGPoint, size: CGSize) {
        self.init()
        origin = CGPoint(x: center.x - size.width / 2, y: center.y - size.height / 2)
        self.size = size
    }
}
