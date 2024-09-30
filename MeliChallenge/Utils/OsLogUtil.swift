//
//  OsLog.swift
//  MeliChallenge
//
//  Created by Yared Nicolas Toro C on 29/09/24.
//

import Foundation
import os.log

extension OSLog {
    
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    static let navigation = OSLog(subsystem: subsystem, category: "navigation")
    static let businessLogic = OSLog(subsystem: subsystem, category: "buisnessLogic")
    static let view = OSLog(subsystem: subsystem, category: "view")
    static let network = OSLog(subsystem: subsystem, category: "networking")
}
