//
//  ProducDetailUseCase.swift
//  MeliChallenge
//
//  Created by Yared Nicolas Toro C on 29/09/24.
//

import Foundation
import Combine

protocol ProductDetailUseCaseProtocol {
    func getProductDetail(with id: String) -> AnyPublisher<ProductDetailResponse, CustomError>
    func getProductDescription(with id: String) -> AnyPublisher<ProductDescriptionResponse, CustomError>
}

class ProductDetailUseCase {

    // MARK: - Private properties -
    private let productDetailRepository: ProductDetailRepositoryProtocol
    
    // MARK: - Lifecycle -
    init(productDetailRepository: ProductDetailRepositoryProtocol) {
        self.productDetailRepository = productDetailRepository
    }
}

// MARK: - ProductDetailRepositoryProtocol -
extension ProductDetailUseCase: ProductDetailRepositoryProtocol {
    func getProductDetail(with id: String) -> AnyPublisher<ProductDetailResponse, CustomError> {
        productDetailRepository.getProductDetail(with: id)
    }
    
    func getProductDescription(with id: String) -> AnyPublisher<ProductDescriptionResponse, CustomError> {
        productDetailRepository.getProductDescription(with: id)
    }
}

