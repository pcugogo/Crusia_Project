//
//  ImageRotating.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 15..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

extension UIView {
    
    func startRotating(duration: Double = 1) {
        let kAnimationKey = "rotation"
        
        if self.layer.animation(forKey: kAnimationKey) == nil {
            let animate = CABasicAnimation(keyPath: "transform.rotation")
            animate.duration = duration
            animate.repeatCount = Float.infinity
            animate.fromValue = 0.0
            animate.toValue = Float(Double.pi * 2.0)
            self.layer.add(animate, forKey: kAnimationKey)
        }
    }
    
    func stopRotating() {
        let kAnimationKey = "rotation"
        
        if self.layer.animation(forKey: kAnimationKey) != nil {
            self.layer.removeAnimation(forKey: kAnimationKey)
        }
    }
}


