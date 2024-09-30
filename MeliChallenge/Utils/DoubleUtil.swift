//
//  File.swift
//  MeliChallenge
//
//  Created by Yared Nicolas Toro C on 29/09/24.
//

import Foundation

extension Double {
    
    func toCurrencyFormat() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = .zero
        return formatter.string(from: NSNumber(value: self))!
    }
}
