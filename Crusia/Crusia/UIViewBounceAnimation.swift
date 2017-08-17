//
//  UIViewBounceAnimation.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 18..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

extension UIView {
    func bounce() {
        self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 0.1,
                       options: UIViewAnimationOptions.beginFromCurrentState,
                       animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
}
