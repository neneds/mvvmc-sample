//
//  UIImage+Extensions.swift
//  MVVMC
//
//  Created by Dennis Merli Rodrigues on 01/12/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

extension UIImage {
    class func loadImageFromURL(url: URL) -> Observable<UIImage?> {
        return Observable<UIImage?>.create({ (observer) -> Disposable in
            let qualityOfServiceClass = DispatchQoS.QoSClass.background
            let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
            backgroundQueue.async(execute: {
                if let data = try? Data(contentsOf: url),let image = UIImage(data: data){
                    observer.onNext(image)
                    observer.onCompleted()
                }else{
                    observer.onNext(nil)
                    observer.onCompleted()
                }
            })
            return Disposables.create()
        }).observeOn(MainScheduler.instance)
    }
}
