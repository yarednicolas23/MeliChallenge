//
//  EncodableUtil.swift
//  MeliChallenge
//
//  Created by Yared Nicolas Toro C on 29/09/24.
//

import Foundation

extension Encodable {
    
    func asDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return [:]
        }
        return dictionary
    }
    
    func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }
}

