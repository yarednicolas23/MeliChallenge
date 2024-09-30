//
//  SearcherViewModel.swift
//  MeliChallenge
//
//  Created by Yared Nicolas Toro C on 29/09/24.
//

import Foundation
import Combine

protocol searchFetchDelegate: AnyObject {
    func didFetchProducts(with response: SearcherResponse)
    func didFailWithError(error: CustomError)
}

class SearchViewModel: ObservableObject {
    
    // MARK: - Public properties -
    @Published var products: [ResultItem] = []
    @Published var allProducts: [ResultItem] = []
    @Published var response: SearcherResponse?
    @Published var isLoading: Bool = false
    @Published var errorMessage: CustomError?
    
    weak var delegate: searchFetchDelegate?
    
    // MARK: - Private properties -
    private let searchProductUseCase: SearchProductUseCase
    private var cancellables: Set<AnyCancellable> = []
    private var query: String = .empty
    private var isFirtsSearch: Bool = true
    
    // MARK: - Lifecycle -
    init(searchProductUseCase: SearchProductUseCase) {
        self.searchProductUseCase = searchProductUseCase
    }
    
    func fetchProductSerach(query: String) {
        guard !isLoading else { return }
        errorMessage = nil
        if self.query != query {
            clearSearch()
        }
        self.query = query
        let offset = isFirtsSearch ? .empty : String(products.count)
        isLoading = true
        searchProductUseCase.getSearchList(query: query, offset: offset)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error
                    self?.delegate?.didFailWithError(error: error)
                }
            } receiveValue: { [weak self] response in
                self?.response = response
                self?.assign(response.results)
                self?.isLoading = false
                self?.delegate?.didFetchProducts(with: response)
            }
            .store(in: &cancellables)
    }
    
    func loadMoreProducts() {
        isFirtsSearch = false
        fetchProductSerach(query: query)
    }
    
    func hasNextPage() -> Bool? {
        guard let total = response?.paging.total else { return nil }
        return total > allProducts.count
    }
    
    func lastProduct() -> ResultItem? {
        allProducts.last
    }
    
    func clearSearch() {
        allProducts = []
        products = []
        response = nil
    }
    
    private func assign(_ products: [ResultItem]) {
        if self.products.isEmpty {
            self.products = products
        } else {
            self.products.append(contentsOf: products)
        }
        allProducts = self.products
    }
}
