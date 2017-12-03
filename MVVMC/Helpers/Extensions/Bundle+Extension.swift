//
//  Bundle+Extension.swift
//  MVVMC
//
//  Created by Dennis Merli Rodrigues on 01/12/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation

extension Bundle {
    static func loadJSONFromBundle(resourceName: String) -> Any? {
        guard let url = Bundle.main.url(forResource: resourceName, withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                return Data()
        }

        do {
            let resultJSON = try JSONSerialization.jsonObject(with: data, options: [])
            return resultJSON
        } catch {
            return nil
        }
    }
}

