//
//  StringUtil.swift
//  MeliChallenge
//
//  Created by Yared Nicolas Toro C on 29/09/24.
//

import Foundation

extension String {
    
    static let empty = ""
    
    func loadJson() -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: self, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
}
