//
//  UIView+Extension.swift
//  MVVMC
//
//  Created by Dennis Merli on 12/4/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    func showActivity(activityStyle: UIActivityIndicatorViewStyle = .gray, blurStyle: UIBlurEffectStyle = .extraLight, blocksInteraction: Bool = false) {

        DispatchQueue.main.async {
            let activityView = UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
            activityView.frame = CGRect(x: 0.0, y: 0.0, width: 75.0, height: 75.0)
            activityView.backgroundColor = UIColor.clear
            activityView.center = CGPoint(x: self.view.frame.width/2.0, y: self.view.frame.height/2.0)
            activityView.layer.cornerRadius = 10.0
            activityView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
            activityView.layer.shadowColor = UIColor.black.cgColor
            activityView.layer.shadowRadius = 7.0
            activityView.layer.shadowOpacity = 0.2
            activityView.layer.masksToBounds = true
            activityView.tag = 999

            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: activityStyle)
            activityIndicator.center = CGPoint(x: activityView.frame.width/2.0, y: activityView.frame.height/2.0)
            activityIndicator.hidesWhenStopped = true

            activityView.contentView.addSubview(activityIndicator)

            self.view.addSubview(activityView)
            activityIndicator.startAnimating()

            self.view.isUserInteractionEnabled = !blocksInteraction
        }
    }

    func hideActivity() {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true

            if let activityIndicator = self.view.subviews.filter({ $0.tag == 999 }).first {
                activityIndicator.removeFromSuperview()
            }
        }
    }

}
