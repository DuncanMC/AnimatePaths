//
//  AnimatePathsView.swift
//  AnimatePaths
//
//  Created by Duncan Champney on 5/10/21.
//

import UIKit

/// A struct to define a path and the duration, pause, and timing function to use for an animation step.
struct PathStep {
    var path: CGPath
    var stepDuration: Double?
    var stepPause: Double?
    var timingFunction: CAMediaTimingFunctionName?
}

/**
 This class uses a `CAShapeLayer` as it's backing layer. It takes an array of `PathStep` objects, and initially installs the path for the first step as the layer's path.
 If you call the `animate(repeats:)` function, it creates a `CAAnimationGroup` of animations that animate the path from the first to the last path in the paths array,
 and back to the initial path.
 */
class AnimatePathsView: UIView {

    var paths: [PathStep]? {
        didSet {
            guard let paths = paths,
                  let firstPath = paths.first?.path,
                  let layer = self.layer as? CAShapeLayer else { return }
            layer.path = firstPath
        }
    }

    var defaultTimingFunction = CAMediaTimingFunctionName.easeInEaseOut
    public var defaultStepDuration: Double = 0.5
    public var defaultStepPause: Double = 0.2

    class override var layerClass: AnyClass {
        return CAShapeLayer.self
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSetup()
    }

    func initSetup() {
        guard let layer = self.layer as? CAShapeLayer else { return }
        layer.fillColor = UIColor.cyan.cgColor
        layer.strokeColor = UIColor.black.cgColor
        layer.lineWidth = 1
        layer.path = nil
    }

    /**
     This function animates the array of paths in the `paths` array from the first to last, and then animates bak to the first element in the array. The 'stepDuration`,`'stepPause`, and `timingFunction` properties of each `PathStep in the array determine the duration of the animation from the previous path to the path contained in that PathStep objects. The animation uses default values for any properties of a PathStep that are nil.
     - Parameter repeats: If true, the animation repeats indefinitely.
     */
    func animate(repeats: Bool) {
        var startTime = 0.0
        guard let layer = self.layer as? CAShapeLayer,
              let paths = paths,
              paths.count > 1 else { return }
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [CABasicAnimation]()
        for index in paths.indices {
            let path = paths[index]
            let nextindex = (index + 1) % paths.count
            let pathAnimation = CABasicAnimation(keyPath: "path")
            let stepDuration = paths[nextindex].stepDuration ?? defaultStepDuration
            pathAnimation.duration = stepDuration
            pathAnimation.beginTime = startTime
            pathAnimation.timingFunction = CAMediaTimingFunction(name: paths[1].timingFunction ?? defaultTimingFunction)
            pathAnimation.fromValue = path.path
            pathAnimation.isRemovedOnCompletion = false
            pathAnimation.fillMode = CAMediaTimingFillMode.forwards
            pathAnimation.toValue = paths[nextindex].path
            startTime += stepDuration + (paths[nextindex].stepPause ?? defaultStepPause)
            animationGroup.animations?.append(pathAnimation)
        }
        animationGroup.duration = startTime
        if repeats {
            animationGroup.repeatCount = .infinity
        }
        layer.add(animationGroup, forKey: nil)
    }
}
