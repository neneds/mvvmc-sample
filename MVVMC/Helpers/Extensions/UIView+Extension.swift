//
//  UIView+Extension.swift
//  MVVMC
//
//  Created by Dennis Merli on 12/4/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    // MARK: Activity indicator that locks interaction
    
    func lockView(duration: TimeInterval = 0.2) {
        
        if let _ = viewWithTag(10) {
            
        } else {
            let lockView = UIView(frame: bounds)
            lockView.backgroundColor = UIColor(white: 0.0, alpha: 0.75)
            lockView.tag = 10
            lockView.alpha = 0.0
            let activity = UIActivityIndicatorView(activityIndicatorStyle: .white)
            activity.hidesWhenStopped = true
            
            activity.center = lockView.center
            
            activity.translatesAutoresizingMaskIntoConstraints = false
            
            lockView.addSubview(activity)
            lockView.bringSubview(toFront: activity)
            activity.startAnimating()
            
            self.addSubview(lockView)
            
            let xCenterConstraint = NSLayoutConstraint(item: activity, attribute: .centerX, relatedBy: .equal, toItem: lockView, attribute: .centerX, multiplier: 1, constant: 0)
            
            let yCenterConstraint = NSLayoutConstraint(item: activity, attribute: .centerY, relatedBy: .equal, toItem: lockView, attribute: .centerY, multiplier: 1, constant: 0)
            
            NSLayoutConstraint.activate([xCenterConstraint, yCenterConstraint])
            
            UIView.animate(withDuration: duration) {
                lockView.alpha = 1.0
            }
        }
    }
    
    func unlockView(duration: TimeInterval = 0.2) {
        
        if let lockView = self.viewWithTag(10) {
            
            UIView.animate(withDuration: duration, animations: {
                lockView.alpha = 0.0
            }) { _ in
                lockView.removeFromSuperview()
            }
        }
    }

}
