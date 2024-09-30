//
//  ProductDetailRepository.swift
//  MeliChallenge
//
//  Created by Yared Nicolas Toro C on 29/09/24.
//

import Foundation
import Combine

protocol ProductDetailRepositoryProtocol {
    func getProductDetail(with id: String) -> AnyPublisher<ProductDetailResponse, CustomError>
    func getProductDescription(with id: String) -> AnyPublisher<ProductDescriptionResponse, CustomError>
}

class ProductDetailRepository {
    
    // MARK: - Private properties -
    private let productDetailRemoteDataSource: ProductDetailRemoteDataSource
    
    // MARK: - Lifecycle -
    init(productDetailRemoteDataSource: ProductDetailRemoteDataSource) {
        self.productDetailRemoteDataSource = productDetailRemoteDataSource
    }
}


// MARK: - ProductDetailRepositoryProtocol -
extension ProductDetailRepository: ProductDetailRepositoryProtocol {
    func getProductDetail(with id: String) -> AnyPublisher<ProductDetailResponse, CustomError> {
        productDetailRemoteDataSource.getProductDetail(with: id)
    }
    
    func getProductDescription(with id: String) -> AnyPublisher<ProductDescriptionResponse, CustomError> {
        productDetailRemoteDataSource.getProductDescription(with: id)
    }
}
