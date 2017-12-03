//
//  UIImage+Extensions.swift
//  MVVMC
//
//  Created by Dennis Merli Rodrigues on 01/12/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {

    func loadImageFromURL(_ url: URL,completion:@escaping (_ image: UIImage?)->Void){
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            if let data = try? Data(contentsOf: url),let image = UIImage(data: data){
                DispatchQueue.main.async(execute: {
                    completion(image)
                })

            }else{
                DispatchQueue.main.async(execute: {
                    completion(nil)
                })
            }
        })
    }
}
