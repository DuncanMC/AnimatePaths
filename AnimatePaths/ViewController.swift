//
//  ViewController.swift
//  AnimatePaths
//
//  Created by Duncan Champney on 5/10/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var pathsView: AnimatePathsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLayoutSubviews() {
        setupAnimationPaths()
    }

    /**
     Install an array of PathStep objects containing a pause button shape and a play button shape into our `pathsView` `AnimatePathsView`
     The shapes are centered in the view.
    */
    func setupAnimationPaths() {

        //-----------------------------
        // Create a path that draws a pause symbol (two vertical bars) centered in the pathsView
        let pausePath =  CGMutablePath()
        let viewMiddleX = pathsView.bounds.midX
        let viewMiddleY = pathsView.bounds.midY
        let pauseBarSize = CGSize(width: 20, height: 90)
        let leftRectOrigin = CGPoint(x: viewMiddleX - pauseBarSize.width * 3 / 2, y: viewMiddleY - pauseBarSize.height / 2 )
        let leftBarRect = CGRect(origin: leftRectOrigin, size: pauseBarSize)
        let rightBarRect = leftBarRect.offsetBy(dx: pauseBarSize.width * 2, dy: 0)
        if true {
            // Create the left rectangle of the pause symbol. We do this by moving to the top left corner, then adding lines clockwise
            // for the remaining 3 points. Finally we call closeSubpath() to turn the rectangle into a closed path.
            // We could also create the 2 rectangles using the CGMutablePath method `addRect(_:transform:)` and the result would be the same.

            var leftBarRectCorners = leftBarRect.corners
            pausePath.move(to: leftBarRectCorners.removeFirst())
            while !leftBarRectCorners.isEmpty {
                pausePath.addLine(to: leftBarRectCorners.removeFirst())
            }
            pausePath.closeSubpath()

            // Create the right side rectangle of the pause symbol
            var rightBarRectCorners = rightBarRect.corners
            pausePath.move(to: rightBarRectCorners.removeFirst())
            while !rightBarRectCorners.isEmpty {
                pausePath.addLine(to: rightBarRectCorners.removeFirst())
            }
            pausePath.closeSubpath()
        } else {
            // This code would have exactly the same result as the code above that draws the rectangle one line segment at a time.
            pausePath.addRect(leftBarRect)
            pausePath.addRect(rightBarRect)
        }

        //--------------------------
        // Create a path that draws a play symbol triangle, but as 2 joined quadralaterals where the right quadralateral
        // has 2 of it's points at the same position so it is drawn in the shape of a triangle.
        let playPath =  CGMutablePath()
        let playPathHeight: CGFloat = 80.0
        let playPathWidth: CGFloat = 76.0

        // Create the left quadralateral as a trapezoid
        playPath.move(   to: CGPoint(x: viewMiddleX - playPathWidth / 2, y: viewMiddleY - playPathHeight / 2))
        playPath.addLine(to: CGPoint(x: viewMiddleX, y: viewMiddleY - playPathHeight / 4 ))
        playPath.addLine(to: CGPoint(x: viewMiddleX, y: viewMiddleY + playPathHeight / 4 ))
        playPath.addLine(to: CGPoint(x: viewMiddleX - playPathWidth / 2, y: viewMiddleY + playPathHeight / 2 ))
        playPath.closeSubpath()

        // Create the right quadralateral with it's right 2 points together, so it draws as a triangle.
        playPath.move(to: CGPoint(x: viewMiddleX, y: viewMiddleY - playPathHeight / 4 ))

        //The right 2 points are the same, turning the quadralateral into a triangle
        playPath.addLine(to: CGPoint(x: viewMiddleX + playPathWidth / 2, y: viewMiddleY))
        playPath.addLine(to: CGPoint(x: viewMiddleX + playPathWidth / 2, y: viewMiddleY))

        playPath.addLine(to: CGPoint(x: viewMiddleX, y: viewMiddleY + playPathHeight / 4))
        playPath.closeSubpath()

        pathsView.paths = [
            PathStep(path: pausePath),
            PathStep(path: playPath)
        ]
    }

    @IBAction func handleAnimateButton(_ sender: Any) {
        pathsView.animate(repeats: false)
    }

}

