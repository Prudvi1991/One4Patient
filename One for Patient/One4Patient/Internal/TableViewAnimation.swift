//
//  TableViewAnimation.swift
//  One for Patient
//
//  Created by Idontknow on 06/02/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//
import UIKit
import Foundation


//MARK:- DirectionType
enum AnimationDirectionType: Int {
    
    case top
    case bottom
    case right
    case left
    
    var isVertical: Bool {
        switch self {
        case .top, .bottom:
            return true
        case .left, .right:
            return false
        }
    }
    
    var isPositive: CGFloat {
        switch self {
        case .top, .left:
            return -1
        case .right, .bottom:
            return 1
        }
    }
    
    //Random direction.
    static func random() -> AnimationDirectionType {
        let rawValue = Int(arc4random_uniform(4))
        return AnimationDirectionType(rawValue: rawValue)!
    }
}

//MARK:- AnimationType
enum AnimationType {
    
    case from(direction: AnimationDirectionType, offSet: CGFloat)
    case zoom(scale: CGFloat)
    case rotate(angle: CGFloat)
    
    var initialTransform: CGAffineTransform {
        switch self {
        case .from(direction: let direction, offSet: let offSet):
            let positive = direction.isPositive
            if direction.isVertical {
                return CGAffineTransform(translationX: 0, y: offSet * positive)
            }
            return CGAffineTransform(translationX: offSet * positive, y: 0)
        case .zoom(scale: let scale):
            return CGAffineTransform(scaleX: scale, y: scale)
        case .rotate(angle: let angle):
            return CGAffineTransform(rotationAngle: angle)
        }
    }
    
    //Generated random animation.
    static func random() -> AnimationType {
        let index = Int(arc4random_uniform(3))
        if index == 1 {
            return AnimationType.from(direction: AnimationDirectionType.random(),
                                      offSet: AnimationConfiguration.offset)
        } else if index == 2 {
            let scale = Double.random(min: 0, max: AnimationConfiguration.maxZoomScale)
            return AnimationType.zoom(scale: CGFloat(scale))
        }
        let angle = CGFloat.random(min: -AnimationConfiguration.maxRotationAngle, max: AnimationConfiguration.maxRotationAngle)
        return AnimationType.rotate(angle: angle)
    }
}


//MARK:- Bool
extension Bool {
    
    //Returns: Bool.
    static func random() -> Bool {
        return arc4random_uniform(2) == 0
    }
}

//MARK:- Double
extension Double {
    
    //Returns a random floating point number between 0.0 and 1.0, inclusive.
    static var random: Double {
        return Double(arc4random()) / 0xFFFFFFFF
    }
    
    //Returns: Generated value.
    static func random(min: Double, max: Double) -> Double {
        return Double.random * (max - min) + min
    }
}

//MARK:- Float Extension
extension Float {
    
    //Returns a random floating point number between 0.0 and 1.0, inclusive.
    static var random: Float {
        return Float(arc4random()) / 0xFFFFFFFF
    }
}

extension CGFloat {
    
    //Returns a random floating point number between 0.0 and 1.0, inclusive.
    static var random: CGFloat {
        return CGFloat(Float.random)
    }
    
    // Returns: Generated value.
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat.random * (max - min) + min
    }
}



//MARK:- AnimationConfiguration
class AnimationConfiguration {
    
    static var offset: CGFloat = 30.0
    
    //Duration of the animation.
    static var duration: Double = 0.35
    
    //Interval for animations handling multiple views that need to be animated one after the other and not at the same time.
    static var interval: Double = 0.035
    
    static var maxZoomScale: Double = 2.0
    
    //Maximum rotation (left or right)
    static var maxRotationAngle: CGFloat = .pi / 4
    
}
