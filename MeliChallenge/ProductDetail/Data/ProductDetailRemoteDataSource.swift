//
//  ProductDetailRemoteDataSource.swift
//  MeliChallenge
//
//  Created by Yared Nicolas Toro C on 29/09/24.
//

import Foundation
import Combine

class ProductDetailRemoteDataSource {
    
    // MARK: - Private properties -
    private var networker: Networking
    private var cancellables: Set<AnyCancellable> = []
    private var nextURL: String?
    
    // MARK: - Lifecycle -
    init(networker: Networking) {
        self.networker = networker
    }
}

extension ProductDetailRemoteDataSource {
    
    func getProductDetail(with id: String) -> AnyPublisher<ProductDetailResponse, CustomError> {
        let request = ProductDetailRequest(with: id)
        return networker.fetch(request).compactMap { response in
            return response
        }.eraseToAnyPublisher()
    }
    
    func getProductDescription(with id: String) -> AnyPublisher<ProductDescriptionResponse, CustomError> {
        let request = ProductDescriptionRequest(id: id)
        return networker.fetch(request).compactMap { response in
            return response
        }.eraseToAnyPublisher()
    }
}

struct ProductDetailRequest: Request {
    
    typealias Output = ProductDetailResponse
    
    var url: URL { URL(string: "https://api.mercadolibre.com/items/\(id)")! }
    var id: String
    var method: HTTPMethod { .get }
    init(with id: String) {
        self.id = id
    }
}

struct ProductDescriptionRequest: Request {
    
    typealias Output = ProductDescriptionResponse
    
    var url: URL { URL(string: "https://api.mercadolibre.com/items/\(id)/description")! }
    var id: String
    var method: HTTPMethod { .get }
    init(id: String) {
        self.id = id
    }
}
