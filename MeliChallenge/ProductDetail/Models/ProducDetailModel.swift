//
//  ProducDetailModel.swift
//  MeliChallenge
//
//  Created by Yared Nicolas Toro C on 29/09/24.
//

import Foundation

// MARK: - Product
struct ProductDetailResponse: Codable, Identifiable {
    let id, siteID, title: String?
    let sellerID: Int?
    let categoryID: String?
    let officialStoreID: Int?
    let price, basePrice: Double?
    let originalPrice: Double?
    let currencyID: String?
    let initialQuantity: Int?
    let saleTerms: [Attribute]?
    let buyingMode, listingTypeID, condition: String?
    let permalink: String?
    let thumbnailID: String?
    let thumbnail: String?
    let pictures: [Picture]?
    let videoID: String?
    let descriptions: [String]?
    let acceptsMercadopago: Bool?
    let nonMercadoPagoPaymentMethods: [String]?
    let shipping: Shipping?
    let internationalDeliveryMode: String?
    let sellerAddress: SellerAddress?
    let sellerContact: SellerContact?
    let location: Location?
    let coverageAreas: [String]?
    let attributes: [Attribute]?
    let listingSource: String?
    let status: String?
    let subStatus: [String]?
    let tags: [String]?
    let warranty, catalogProductID, domainID: String?
    let parentItemID: String?
    let dealIDS: [String]?
    let automaticRelist: Bool?
    let dateCreated, lastUpdated: String?
    let health: Double?
    let catalogListing: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case siteID = "site_id"
        case title
        case sellerID = "seller_id"
        case categoryID = "category_id"
        case officialStoreID = "official_store_id"
        case price
        case basePrice = "base_price"
        case originalPrice = "original_price"
        case currencyID = "currency_id"
        case initialQuantity = "initial_quantity"
        case saleTerms = "sale_terms"
        case buyingMode = "buying_mode"
        case listingTypeID = "listing_type_id"
        case condition, permalink
        case thumbnailID = "thumbnail_id"
        case thumbnail, pictures
        case videoID = "video_id"
        case descriptions
        case acceptsMercadopago = "accepts_mercadopago"
        case nonMercadoPagoPaymentMethods = "non_mercado_pago_payment_methods"
        case shipping
        case internationalDeliveryMode = "international_delivery_mode"
        case sellerAddress = "seller_address"
        case sellerContact = "seller_contact"
        case location
        case coverageAreas = "coverage_areas"
        case attributes
        case listingSource = "listing_source"
        case status
        case subStatus = "sub_status"
        case tags, warranty
        case catalogProductID = "catalog_product_id"
        case domainID = "domain_id"
        case parentItemID = "parent_item_id"
        case dealIDS = "deal_ids"
        case automaticRelist = "automatic_relist"
        case dateCreated = "date_created"
        case lastUpdated = "last_updated"
        case health
        case catalogListing = "catalog_listing"
    }
}


// MARK: - Value
struct Value: Codable {
    let id: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id, name
    }
}

// MARK: - Location
struct Location: Codable {
}

// MARK: - Picture
struct Picture: Codable, Identifiable {
    let id: String?
    let url: String?
    let secureURL: String
    let size, maxSize, quality: String?

    enum CodingKeys: String, CodingKey {
        case id, url
        case secureURL = "secure_url"
        case size
        case maxSize = "max_size"
        case quality
    }
}

// MARK: - SellerAddress
struct SellerAddress: Codable {
    let city, state, country: City?
    let searchLocation: SearchLocation?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case city, state, country
        case searchLocation = "search_location"
        case id
    }
}

// MARK: - SellerContact
struct SellerContact: Codable {
    let contact, otherInfo, countryCode, areaCode: String?
    let phone, countryCode2, areaCode2, phone2: String?
    let email, webpage: String?

    enum CodingKeys: String, CodingKey {
        case contact
        case otherInfo = "other_info"
        case countryCode = "country_code"
        case areaCode = "area_code"
        case phone
        case countryCode2 = "country_code2"
        case areaCode2 = "area_code2"
        case phone2, email, webpage
    }
}

// MARK: - City
struct City: Codable {
    let id, name: String?
}

// MARK: - SearchLocation
struct SearchLocation: Codable {
    let city, state: City?
}
