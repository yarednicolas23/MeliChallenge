//
//  SearcherProductsUseCase.swift
//  MeliChallenge
//
//  Created by Yared Nicolas Toro C on 29/09/24.
//

import Foundation
import Combine

protocol SearchProductUseCaseProtocol {
    func searchProduct(query: String, offset: String) -> AnyPublisher<SearcherResponse, CustomError>
}

class SearchProductUseCase {

    // MARK: - Private properties -
    private let searchProductsRepository: SearchProductsRepositoryProtocol
    
    // MARK: - Lifecycle -
    init(searchProductsRepository: SearchProductsRepositoryProtocol) {
        self.searchProductsRepository = searchProductsRepository
    }
}

// MARK: - SearchProductsRepositoryProtocol -
extension SearchProductUseCase: SearchProductsRepositoryProtocol {

    func getSearchList(query: String, offset: String) -> AnyPublisher<SearcherResponse, CustomError> {
        searchProductsRepository.getSearchList(query: query, offset: offset)
    }
}
