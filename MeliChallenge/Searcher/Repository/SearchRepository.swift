//
//  SearchRepository.swift
//  MeliChallenge
//
//  Created by Yared Nicolas Toro C on 29/09/24.
//

import Foundation
import Combine

protocol SearchProductsRepositoryProtocol {
    func getSearchList(query: String, offset: String) -> AnyPublisher<SearcherResponse, CustomError>
}

class SarchProductsRepository {
    
    // MARK: - Private properties -
    private let searchProductsRemoteDataSource: SearchProductsRemoteDataSource
    
    // MARK: - Lifecycle -
    init(SearchProductsRemoteDataSource: SearchProductsRemoteDataSource) {
        self.searchProductsRemoteDataSource = SearchProductsRemoteDataSource
    }
}

extension SarchProductsRepository: SearchProductsRepositoryProtocol {
    
    func getSearchList(query: String, offset: String) -> AnyPublisher<SearcherResponse, CustomError> {
        searchProductsRemoteDataSource.getSearchList(query: query, offset: offset)
    }
}


