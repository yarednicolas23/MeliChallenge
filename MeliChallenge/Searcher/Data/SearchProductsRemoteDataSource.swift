//
//  SearchProductsRemoteDataSource.swift
//  MeliChallenge
//
//  Created by Yared Nicolas Toro C on 29/09/24.
//

import Foundation
import Combine

class SearchProductsRemoteDataSource {
    
    // MARK: - Private properties -
    private var networker: Networking
    private var cancellables: Set<AnyCancellable> = []
    private var nextURL: String?
    
    // MARK: - Lifecycle -
    init(networker: Networking) {
        self.networker = networker
    }
}

extension SearchProductsRemoteDataSource {
    
    func getSearchList(query: String, offset: String) -> AnyPublisher<SearcherResponse, CustomError> {
        let request = SearchProductListRequest(query: query, offset: offset)
        return networker.fetch(request).compactMap { response in
            return response
        }.eraseToAnyPublisher()
    }
}

struct SearchProductListRequest: Request {
    
    typealias Output = SearcherResponse
    
    var url: URL { URL(string: "https://api.mercadolibre.com/sites/MLA/search")! }
    var query: String
    var offset: String
    var method: HTTPMethod { .get }
    
    var parameters: Encodable? {[
        "q": query,
        "offset": offset
    ]}
    
    init(query: String, offset: String) {
        self.query = query
        self.offset = offset
    }
}
