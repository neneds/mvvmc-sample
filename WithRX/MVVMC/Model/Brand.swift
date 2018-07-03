//
//  Brand.swift
//  MVVMC
//
//  Created by Dennis Merli on 12/1/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation


class Brand: Codable {
    var id: String?
    var name: String?
    var brandDescription: String?
    var brandImageURL: URL?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case brandDescription = "brandDescription"
        case brandImageURL = "brandImageURL"
    }
}
