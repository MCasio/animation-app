//
//  DetailViewController.swift
//  animation-app
//
//  Created by Mahmoud Mohammed on 8/19/18.
//  Copyright © 2018 Mahmoud Mohammed. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
// MARK: - Properties
    var barTitle = ""
    var animateView: UIView!
    private let duration = 2.0
    private let delay = 0.2
    private let scale = 1.2
    
    
    
// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRect()
    }
    

    
// MARK: - Methods    
    private func setupRect() {
        if barTitle == "BezierCurve Position" {
            animateView = drawCircleView()
        } else if barTitle == "View Fade In" {
            animateView = UIImageView(image: UIImage(named: "whatsapp"))
            animateView.frame = generalFrame
            animateView.center = generalCenter
        } else {
            animateView = drawRectView(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), frame: generalFrame, center: generalCenter)
        }
        view.addSubview(animateView)
    }

    
// MARK: - IBActions

    @IBAction func didTapAnimate(_ sender: Any) {
        switch barTitle {
        case "2-Color":
            changeColor(#colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1))
        case "Simple 2D Rotation":
            rotateView(Double.pi)
        case "Multicolor":
            multiColor(UIColor.green, UIColor.blue)
        case "Multi Point Position":
            multiPosition(CGPoint(x: animateView.frame.origin.x, y: 100), secondPos: CGPoint(x: animateView.frame.origin.x, y: 350))
        case "BezierCurve Position":
            var controlPoint1 = self.animateView.center
            controlPoint1.y -= 125.0
            var controlPoint2 = controlPoint1
            controlPoint2.x += 40.0
            controlPoint2.y -= 125.0
            var endPoint = self.animateView.center
            endPoint.x += 75.0
            curvePath(endPoint, controlPoint1, ControlPoint2: controlPoint2)
        case "Color and Frame Change":
            let currentFrame = animateView.frame
            let firstFrame = currentFrame.insetBy(dx: -30, dy: -50)
            let secondFrame = firstFrame.insetBy(dx: 10, dy: 15)
            let thirdFrame = secondFrame.insetBy(dx: -15, dy: -20)
            colorFrameChange(firstFrame, secondFrame, thirdFrame, UIColor.orange, UIColor.yellow, UIColor.green)
        case "View Fade In":
            viewFadeIn()
        case "Pop":
            pop()
        
        default:
            let alert = makeAlert("Alert", message: "The animation not implemented yet", actionTitle: "OK")
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    

// MARK: - Private Methods for Animations
    private func changeColor(_ color: UIColor) {
        UIView.animate(withDuration: duration, animations: {
            self.animateView.backgroundColor = color
        }, completion: nil)
    }
    
    private func multiColor(_ firstColor: UIColor, _ secondColor: UIColor) {
        UIView.animate(withDuration: duration, animations: {
            self.animateView.backgroundColor = firstColor
        }) { (finished) in
            self.changeColor(secondColor)
        }
    }
    
    private func multiPosition(_ firstPos: CGPoint, secondPos: CGPoint) {
        func simplePosition(_ pos: CGPoint) {
            UIView.animate(withDuration: duration, animations: {
                self.animateView.frame.origin = pos
            }, completion: nil)
        }
        
        UIView.animate(withDuration: duration, animations: {
            self.animateView.frame.origin = firstPos
        }) { (finished) in
            simplePosition(secondPos)
        }
    }
    
    private func rotateView(_ angle: Double) {
        UIView.animate(withDuration: duration, delay: delay, options: [.repeat], animations: {
            self.animateView.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
        }, completion: nil)
    }

    private func colorFrameChange(_ firstFrame: CGRect, _ secondFrame: CGRect, _ thirdFrame: CGRect,
                                  _ firstColor: UIColor,_ secondColor: UIColor,_ thirdColor: UIColor) {
        UIView.animate(withDuration: duration, animations: {
            self.animateView.backgroundColor = firstColor
            self.animateView.frame = firstFrame
        }) { (finished) in
            UIView.animate(withDuration: self.duration, animations: {
                self.animateView.backgroundColor = secondColor
                self.animateView.frame = secondFrame
            }, completion: { (finished) in
                UIView.animate(withDuration: self.duration, animations: {
                    self.animateView.backgroundColor = thirdColor
                    self.animateView.frame = thirdFrame
                }, completion: nil)
            })
        }
    }

    private func curvePath(_ endPoint: CGPoint, _ controlPoint1: CGPoint, ControlPoint2: CGPoint) {
        let path = UIBezierPath()
        path.move(to: self.animateView.center)
        
        path.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: ControlPoint2)
        
        let anim = CAKeyframeAnimation(keyPath: "position")
        
        anim.path = path.cgPath
        
        anim.duration = duration
        
        animateView.layer.add(anim, forKey: "animate position along path")
        animateView.center = endPoint
    }

    private func viewFadeIn() {
        let secondView = UIImageView(image: UIImage(named: "facebook"))
        secondView.frame = animateView.frame
        secondView.alpha = 0.0
        
        view.insertSubview(secondView, aboveSubview: animateView)
        
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
            secondView.alpha = 1.0
            self.animateView.alpha = 0.0
        }, completion: nil)
    }

    private func pop() {
        UIView.animate(withDuration: duration / 4, animations: {
            self.animateView.transform = CGAffineTransform(scaleX: CGFloat(self.scale), y: CGFloat(self.scale))
        }) { (finished) in
            UIView.animate(withDuration: self.duration / 4, animations: {
                self.animateView.transform = CGAffineTransform.identity
            })
        }
    }
}
