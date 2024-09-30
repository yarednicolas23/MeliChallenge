//
//  SearcherView.swift
//  MeliChallenge
//
//  Created by Yared Nicolas Toro C on 29/09/24.
//

import SwiftUI

struct SearcherView: View {
    
    @EnvironmentObject var appModel: AppViewModel
    var animation: Namespace.ID
    
    @StateObject private var viewModel = SearchViewModel(
        searchProductUseCase: SearchProductUseCase(
            searchProductsRepository: SarchProductsRepository(
                SearchProductsRemoteDataSource: SearchProductsRemoteDataSource(networker: Networker())
            )
        )
    )
    
    var body: some View {
        
        SearcherHeaderView(delegate: self)
        
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.allProducts, id: \.self) { product in
                    SearcherProductListCellView(animation: animation, item: product)
                        .onAppear {
                            tryToLoadMoreProducts(for: product)
                        }
                }
            }
        }
    }
        
    
    func tryToLoadMoreProducts(for product: ResultItem) {
        if product == viewModel.lastProduct(),
           viewModel.hasNextPage() ?? false,
           !viewModel.isLoading {
            viewModel.loadMoreProducts()
        }
    }
}

// MARK: - SearchDelegate

extension SearcherView: SearchDelegate {
    
    var placeHolder: String { return "Buscar en Mercado libre" }
    
    func search(query: String) {
        if query.isEmpty {
            viewModel.clearSearch()
        }
        guard query.count > 3 else { return }
        viewModel.fetchProductSerach(query: query)
    }
}

// MARK: - GridViewDelegate -

extension SearcherView: GridViewDelegate {
    
    var isSearching: Bool {
        viewModel.isLoading
    }
    
    func hasNext() -> Bool {
        viewModel.hasNextPage() ?? false
    }
}
