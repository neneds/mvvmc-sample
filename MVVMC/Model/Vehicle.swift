//
//  Vehicle.swift
//  MVVMC
//
//  Created by Dennis Merli on 11/29/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation


class Vehicle : NSObject {
    var id: String?
    var name: String?
    var maker: String?
    var urlImage: URL?
    var vehicleDescription: String?
    
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        id <- map["id"]
        name <- map["name"]
        maker <- map["brandName"]
        urlImage <- map["pictureAddress"]
        vehicleDescription <- map["vehicleDescription"]
    }
}
    
