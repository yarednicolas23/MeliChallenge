//
//  ProductDescriptionModel.swift
//  MeliChallenge
//
//  Created by Yared Nicolas Toro C on 29/09/24.
//

import Foundation

// MARK: - ProductDescription
struct ProductDescriptionResponse: Codable {
    let text: String
    let plainText: String
    let lastUpdated, dateCreated: String?
    let snapshot: Snapshot?

    enum CodingKeys: String, CodingKey {
        case text
        case plainText = "plain_text"
        case lastUpdated = "last_updated"
        case dateCreated = "date_created"
        case snapshot
    }
}

// MARK: - Snapshot
struct Snapshot: Codable {
    let url: String?
    let width, height: Int?
    let status: String?
}
