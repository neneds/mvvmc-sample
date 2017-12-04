//
//  Brand.swift
//  MVVMC
//
//  Created by Dennis Merli on 12/1/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation
import ObjectMapper

class Brand: Mappable {
    var id: String?
    var name: String?
    var brandDescription: String?
    var brandImageURL: URL?


    required init?(map: Map) {
     
    }

   func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        brandDescription <- map["brandDescription"]
        brandImageURL <- (map["brandImageURL"], TransformersUtils.URLTransformer)
    }
}
