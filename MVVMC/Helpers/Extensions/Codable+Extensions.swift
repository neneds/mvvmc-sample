//
//  Codable+Extensions.swift
//  MVVMC
//
//  Created by Dennis Merli Rodrigues on 21/06/18.
//  Copyright © 2018 Dennis Merli. All rights reserved.
//

import Foundation

extension Decodable {
    static func decode(data: Data) throws -> Self {
        let decoder = JSONDecoder()
        return try decoder.decode(Self.self, from: data)
    }
}

extension Encodable {
    func encode() throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(self)
    }
    
    func encodeToJSONObject() throws -> [String: Any]? {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self) else { return nil }
        return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
}
