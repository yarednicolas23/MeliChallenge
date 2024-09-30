//
//  SearcherModel.swift
//  MeliChallenge
//
//  Created by Yared Nicolas Toro C on 29/09/24.
//

import Foundation

// MARK: - Paging -
struct Paging: Codable {
    let total: Int
    let offset: Int
    let limit: Int
    let primaryResults: Int

    enum CodingKeys: String, CodingKey {
        case total
        case offset
        case limit
        case primaryResults = "primary_results"
    }
}

// MARK: - Seller -
struct Seller: Codable, Hashable {
    let id: Int
    let nickname: String
}

// MARK: - Installments -
struct Installments: Codable, Hashable {
    let quantity: Int
    let amount: Double
    let rate: Double
    let currencyId: String

    enum CodingKeys: String, CodingKey {
        case quantity
        case amount
        case rate
        case currencyId = "currency_id"
    }
}

// MARK: - Shipping -
struct Shipping: Codable, Hashable {
    let freeShipping: Bool
    let mode: String
    let logisticType: String
    let storePickUp: Bool

    enum CodingKeys: String, CodingKey {
        case freeShipping = "free_shipping"
        case mode
        case logisticType = "logistic_type"
        case storePickUp = "store_pick_up"
    }
}

// MARK: - Attribute -
struct Attribute: Codable {
    let values: [AttributeValue]?
    let attributeGroupId: String?
    let attributeGroupName: String?
    let id: String
    let valueId: String?
    let source: Int?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case values
        case attributeGroupId = "attribute_group_id"
        case attributeGroupName = "attribute_group_name"
        case id
        case valueId = "value_id"
        case source
        case name
    }
}

// MARK: - AttributeValue -
struct AttributeValue: Codable {
    let source: Int?
    let id: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case source
        case id
        case name
    }
}

// MARK: - SearchResponse -
struct SearcherResponse: Codable {
    let siteID: String?
    let countryDefaultTimeZone: String
    let query: String
    let paging: Paging
    let results: [ResultItem]

    enum CodingKeys: String, CodingKey {
        case siteID = "site_id"
        case countryDefaultTimeZone = "country_default_time_zone"
        case query, paging, results
    }
}

struct ResultItem: Codable, Hashable, Identifiable {
    let id: String
    let title: String
    let condition: String
    let thumbnailID: String
    let listingTypeID: String
    let sanitizedTitle: String
    let permalink: String
    let buyingMode: String
    let siteID: String?
    let categoryID: String
    let domainID: String
    let variationID: String?
    let thumbnail: String
    let currencyID: String
    let orderBackend: Int
    let price: Double
    let originalPrice: Double?
    let salePrice: SalePrice
    let availableQuantity: Int
    let officialStoreID: Int?
    let useThumbnailID: Bool
    let acceptsMercadopago: Bool
    let variationFilters: [String]?
    let shipping: Shipping
    let stopTime: String
    let seller: Seller
    let installments: Installments?
    let winnerItemID: String?
    let catalogListing: Bool
    let discounts: String?
    let promotions: [String]
    let inventoryID: String?

    enum CodingKeys: String, CodingKey {
        case id, title, condition
        case thumbnailID = "thumbnail_id"
        case listingTypeID = "listing_type_id"
        case sanitizedTitle = "sanitized_title"
        case permalink
        case buyingMode = "buying_mode"
        case siteID = "site_id"
        case categoryID = "category_id"
        case domainID = "domain_id"
        case variationID = "variation_id"
        case thumbnail
        case currencyID = "currency_id"
        case orderBackend = "order_backend"
        case price
        case originalPrice = "original_price"
        case salePrice = "sale_price"
        case availableQuantity = "available_quantity"
        case officialStoreID = "official_store_id"
        case useThumbnailID = "use_thumbnail_id"
        case acceptsMercadopago = "accepts_mercadopago"
        case variationFilters = "variation_filters"
        case shipping
        case stopTime = "stop_time"
        case seller
        case installments
        case winnerItemID = "winner_item_id"
        case catalogListing = "catalog_listing"
        case discounts, promotions
        case inventoryID = "inventory_id"
    }
    
    func itemImageURL() -> URL {
        URL(string: thumbnail)!
    }
}

struct SalePrice: Codable, Hashable {
    let priceID: String
    let amount: Double
    let conditions: Conditions
    let currencyID: String
    let exchangeRate: String?
    let paymentMethodPrices: [String]
    let paymentMethodType: String
    let regularAmount: Decimal?
    let type: String

    enum CodingKeys: String, CodingKey {
        case priceID = "price_id"
        case amount
        case conditions
        case currencyID = "currency_id"
        case exchangeRate = "exchange_rate"
        case paymentMethodPrices = "payment_method_prices"
        case paymentMethodType = "payment_method_type"
        case regularAmount = "regular_amount"
        case type
    }
}

struct Conditions: Codable, Hashable {
    let eligible: Bool
    let contextRestrictions: [String]
    let startTime: String?
    let endTime: String?

    enum CodingKeys: String, CodingKey {
        case eligible
        case contextRestrictions = "context_restrictions"
        case startTime = "start_time"
        case endTime = "end_time"
    }
}

struct VariationData: Codable {
    let thumbnail: String
    let ratio: String
    let name: String
    let picturesQty: Int
    let price: Double
    let userProductID: String

    enum CodingKeys: String, CodingKey {
        case thumbnail, ratio, name
        case picturesQty = "pictures_qty"
        case price
        case userProductID = "user_product_id"
    }
}

struct VariationAttribute: Codable {
    let id: String
    let name: String
    let valueName: String
    let valueType: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case valueName = "value_name"
        case valueType = "value_type"
    }
}


extension ResultItem: Equatable {
    
    static func == (lhs: ResultItem, rhs: ResultItem) -> Bool {
        lhs.id == rhs.id
    }
}
