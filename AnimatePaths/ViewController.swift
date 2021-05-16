//
//  ViewController.swift
//  AnimatePaths
//
//  Created by Duncan Champney on 5/10/21.
//

import CoreGraphics
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var pathsView: AnimatePathsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pathsView.defaultStepPause = 0
        pathsView.defaultTimingFunction =  CAMediaTimingFunctionName.linear
        pathsView.defaultStepDuration = 0.7
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLayoutSubviews() {
        setupAnimationPaths()
    }

    func intertwinePointsArrays(array1: [CGPoint], array2: [CGPoint]) -> [CGPoint] {
        return zip(array1, array2).flatMap {[$0, $1]}
    }

    func pathForRects(cornersRect: CGRect, sidesRect: CGRect) -> CGPath {
        let path = CGMutablePath()
        var points = intertwinePointsArrays(array1: cornersRect.corners, array2: sidesRect.centerpoints)
        path.move(to: points.removeFirst())
        while !points.isEmpty {
            path.addLine(to: points.removeFirst())
        }
        path.closeSubpath()
        return path
    }

    /**
     Install an array of PathStep objects containing a pause button shape and a play button shape into our `pathsView` `AnimatePathsView`
     The shapes are centered in the view.
    */
    func setupAnimationPaths() {

        var paths = [PathStep]()
        var smallRect: CGRect
        var largeRect: CGRect

        let viewCenter = CGPoint(x: pathsView.bounds.width/2, y: pathsView.bounds.height/2)
        smallRect = CGRect(center: viewCenter, size: CGSize(width: 0, height: 0))
        largeRect = CGRect(center: viewCenter, size: CGSize(width: 10, height: 10))
        paths.append(PathStep(path:pathForRects(cornersRect: smallRect, sidesRect: smallRect)))

        paths.append(PathStep(path:pathForRects(cornersRect: smallRect, sidesRect: largeRect)))
//        paths.append(PathStep(path:pathForRects(cornersRect: largeRect, sidesRect: smallRect),stepPause: 0.5))


        smallRect = CGRect(center: viewCenter, size: CGSize(width: 10, height: 10))
        paths.append(PathStep(path:pathForRects(cornersRect: smallRect, sidesRect: largeRect)))

        largeRect = CGRect(center: viewCenter, size: CGSize(width: 100, height: 100))

        paths.append(PathStep(path:pathForRects(cornersRect: smallRect, sidesRect: largeRect)))
        let path = pathForRects(cornersRect: largeRect, sidesRect: smallRect)
        paths.append(PathStep(path: path))

        smallRect = CGRect(center: viewCenter, size: CGSize(width: 100, height: 100))
        paths.append(PathStep(path:pathForRects(cornersRect: smallRect, sidesRect: largeRect)))

        let viewSmallest = min(pathsView.bounds.width, pathsView.bounds.height) - 5
        largeRect = CGRect(center: viewCenter, size: CGSize(width: viewSmallest, height: viewSmallest))
        paths.append(PathStep(path:pathForRects(cornersRect: smallRect, sidesRect: largeRect)))

        paths.append(PathStep(path:pathForRects(cornersRect: largeRect, sidesRect: smallRect)))

        smallRect = CGRect(center: viewCenter, size: CGSize(width: viewSmallest, height: viewSmallest))
        paths.append(PathStep(path:pathForRects(cornersRect: smallRect, sidesRect: largeRect)))

        paths.append(contentsOf: paths.reversed())

        pathsView.paths = paths
    }

    @IBAction func handleAnimateButton(_ sender: Any) {
        pathsView.animate(repeats: false)
    }

}

