//
//  ContentView.swift
//  MeliChallenge
//
//  Created by Yared Nicolas Toro C on 29/09/24.
//

import SwiftUI
import OSLog

class AppViewModel: ObservableObject {
    // MARK: Home Properties
    @Published var currentMenu: String = "All"
    // MARK: Detail View Properties
    @Published var showDetailView: Bool = false
    @Published var currentItemSelected: ResultItem?
}


struct ContentView: View {
    
    @StateObject var appModel: AppViewModel = .init()
    @Namespace var animation
    
    var body: some View {
        SearcherView(animation: animation)
            .environmentObject(appModel)
            .overlay(alignment: .topTrailing) {
                if let product = appModel.currentItemSelected, appModel.showDetailView {
                    // MARK: Detail View
                    ProductDetailView(animation: animation, id: product.id)
                        .environmentObject(appModel)
                }
            }
    }
}

#Preview {
    ContentView()
}
