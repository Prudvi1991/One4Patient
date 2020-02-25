//
//  Button+Ext.swift
//  One for Patient
//
//  Created by Idontknow on 21/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import Foundation
import UIKit


extension UIButton {
    
    
    func pulse() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }
    
    func flash() {
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.2
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        
        layer.add(flash, forKey: nil)
    }
    
    
    func shake() {
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.07
        shake.repeatCount = 3
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
    func makeRound() {
        
//        self.layer.borderWidth = 0.3
        self.layer.masksToBounds = true
//        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    func addBorder() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
    }
    
}


extension UILabel{
    
    func pulse() {
           
           let pulse = CASpringAnimation(keyPath: "transform.scale")
           pulse.duration = 0.2
           pulse.fromValue = 0.95
           pulse.toValue = 1.0
           pulse.autoreverses = true
           pulse.repeatCount = 2
           pulse.initialVelocity = 0.5
           pulse.damping = 1.0
           
           layer.add(pulse, forKey: "pulse")
       }
       
       func flash() {
           
           let flash = CABasicAnimation(keyPath: "opacity")
           flash.duration = 0.2
           flash.fromValue = 1
           flash.toValue = 0.1
           flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
           flash.autoreverses = true
           flash.repeatCount = 3
           
           layer.add(flash, forKey: nil)
       }
       
       
       func shake() {
           
           let shake = CABasicAnimation(keyPath: "position")
           shake.duration = 0.07
           shake.repeatCount = 3
           shake.autoreverses = true
           
           let fromPoint = CGPoint(x: center.x - 5, y: center.y)
           let fromValue = NSValue(cgPoint: fromPoint)
           
           let toPoint = CGPoint(x: center.x + 5, y: center.y)
           let toValue = NSValue(cgPoint: toPoint)
           
           shake.fromValue = fromValue
           shake.toValue = toValue
           
           layer.add(shake, forKey: "position")
       }
       func makeRound() {
           
//           self.layer.borderWidth = 0.5
//           self.layer.borderColor = UIColor.black.cgColor
           self.layer.cornerRadius = self.frame.height/2
           self.clipsToBounds = true
       }
    
    func heightForLabel(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }
    func addBorder() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 5.0
    }
       
}

extension UISegmentedControl {
    
    func makeRound() {
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height/2
    }
    
}
