//
//  GridView.swift
//  MeliChallenge
//
//  Created by Yared Nicolas Toro C on 29/09/24.
//

import SwiftUI

protocol GridViewDelegate {
    var isSearching: Bool { get }
    func hasNext() -> Bool
}

struct GridView<Content>: View where Content: View {
    
    // MARK: - Private properties -
    
    private let columns = [ GridItem(.adaptive(minimum: 160)) ]
    
    // MARK: - Public properties -
    
    let delegate: GridViewDelegate
    let content: () -> Content
    
    var body: some View {
        VStack {
            gridView()
        }
        .background((Color(red: 242/255, green:  242/255, blue:  242/255, opacity: 1)))
    }
    
    // MARK: - Private methods -
    
    private func waiting() -> some View {
        VStack(alignment: .center) {
            ActivityIndicator(size: 55, color: .yellow, velocity: 7.0)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func gridView() -> some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    self.content()
                }
                .padding([.horizontal, .bottom])
                
                if delegate.hasNext(), !delegate.isSearching {
                    ActivityIndicator(size: 60, color: .yellow)
                }
            }
        }
        .padding(.top)
    }
}

protocol GridCellProtocol {
    var identifier: String { get }
    var headline: String { get }
    var imageURL: URL? { get }
}
