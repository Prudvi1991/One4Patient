//
//  TabBarCntrl.swift
//  One for Patient
//
//  Created by Idontknow on 21/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import Foundation
import UIKit

class AnimatedTabBarController: UITabBarController {
    
    private var bounceAnimation: CAKeyframeAnimation = {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.4, 0.9, 1.02, 1.0]
        bounceAnimation.duration = TimeInterval(0.3)
        bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
        return bounceAnimation
    }()
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        var tabBarView: [UIView] = []

        for i in tabBar.subviews {
            if i.isKind(of: NSClassFromString("UITabBarButton")! ) {
                tabBarView.append(i)
            }
        }
        
        if !tabBarView.isEmpty {
            
            UIView.animate(withDuration: 0.15, animations: {
                tabBarView[item.tag].transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }, completion: { _ in
                UIView.animate(withDuration: 0.15) {
                    tabBarView[item.tag].transform = CGAffineTransform.identity
                }
            })
        }
    }
}
