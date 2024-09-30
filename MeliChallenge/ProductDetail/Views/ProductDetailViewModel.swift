//
//  ProductDetailViewModel.swift
//  MeliChallenge
//
//  Created by Yared Nicolas Toro C on 29/09/24.
//

import Foundation
import Combine

class ProductDetailViewModel: ObservableObject {
    
    // MARK: - Public properties -
    @Published var detail: ProductDetailResponse?
    @Published var description: ProductDescriptionResponse?
    @Published var isLoading: Bool = false
    @Published var errorMessage: CustomError?
    
    // MARK: - Private properties -
    private let productDetailUseCase: ProductDetailUseCase
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Lifecycle -
    init(productDetailUseCase: ProductDetailUseCase) {
        self.productDetailUseCase = productDetailUseCase
    }
    
    func fetchProductDetail(id: String) {
        guard !isLoading else { return }
        errorMessage = nil
        isLoading = true
        productDetailUseCase.getProductDetail(with: id)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error
                }
            } receiveValue: { [weak self] response in
                self?.detail = response
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func fetchProductDescription(id: String) {
        errorMessage = nil
        isLoading = true
        productDetailUseCase.getProductDescription(with: id)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error
                }
            } receiveValue: { [weak self] response in
                self?.description = response
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
}

