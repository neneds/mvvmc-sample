//
//  TransformersUtils.swift
//  MVVMC
//
//  Created by Dennis Merli Rodrigues on 01/12/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation
import ObjectMapper



class TransformersUtils : NSObject {
    static let URLTransformer: TransformOf<URL, String> = TransformOf<URL, String>(fromJSON: { (strUrl) -> URL? in
        return URL(string: strUrl ?? "")
    }) { (url) -> String? in
        return url?.absoluteString
    }
}
