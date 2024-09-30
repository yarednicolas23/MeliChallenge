//
//  ProductDetailView.swift
//  MeliChallenge
//
//  Created by Yared Nicolas Toro C on 29/09/24.
//

import SwiftUI
import Combine
import OSLog

struct ProductDetailView: View {
    
    @Environment(\.openURL) var openURL
    var animation: Namespace.ID
    @EnvironmentObject var appModel: AppViewModel
    @State var showDetailContent: Bool = false
    
    @State var currentPage = 0
    @StateObject var viewModel = ProductDetailViewModel(
        productDetailUseCase: ProductDetailUseCase(
            productDetailRepository: ProductDetailRepository(
                productDetailRemoteDataSource: ProductDetailRemoteDataSource(networker: Networker())
            )
        )
    )
    let id: String
    
    var body: some View {
        
        GeometryReader{ proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // MARK: Custom Nav Bar
                    HStack{
                        Button {
                            withAnimation(.easeInOut){
                                showDetailContent = false
                            }
                            withAnimation(.easeInOut.delay(0.1)){
                                appModel.showDetailView = false
                            }
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .padding(12)
                                .background{
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.white)
                                }
                        }
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "suit.heart.fill")
                                .foregroundColor(Color.red)
                                .padding(12)
                                .background{
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.white)
                                }
                        }
                    }
                    .padding()
                    
                    
                    TabView(selection: $currentPage) {
                        ForEach(0..<(viewModel.detail?.pictures?.count ?? 0), id: \.self) { index in
                            if let picture = viewModel.detail?.pictures?[index],
                               let url = URL(string: picture.secureURL) {
                                pageView(with: url)
                                    .padding()
                                    .tag(index)
                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    .frame(width: 350, height: 350)
                    .padding(.horizontal)
                    .overlay(
                        Text("\(currentPage + 1) / \(viewModel.detail?.pictures?.count ?? 1)")
                            .padding(8)
                            .padding(.horizontal, 8)
                            .foregroundColor(.black)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(25),
                        alignment: .topLeading
                    )
                    
                    
                    Text(viewModel.detail?.condition?.capitalized ?? .empty)
                        .frame(alignment: .leading)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .fixedSize()
                        .matchedGeometryEffect(id: id + "CONDITION", in: animation)
                    
                    Text(viewModel.detail?.title ?? "N/A")
                        .font(.callout)
                        .fontWeight(.light)
                        .foregroundColor(.black)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .matchedGeometryEffect(id: id + "TITLE", in: animation)
                    
                    Text(viewModel.detail?.price?.toCurrencyFormat() ?? .empty)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    if let warranty = viewModel.detail?.warranty, warranty != .empty {
                        Text(warranty)
                            .frame(alignment: .leading)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Text("Stock disponible")
                        .frame(alignment: .leading)
                        .font(.subheadline)
                        .foregroundColor(.black)

                    
                    if viewModel.detail?.shipping?.freeShipping == true {
                        Text("Envío gratis")
                            .frame(alignment: .leading)
                            .font(.callout)
                            .foregroundColor(.green)
                        
                        Text("Almacenado y enviado por FULL")
                            .frame(alignment: .leading)
                            .font(.callout)
                            .foregroundColor(.green)
                        
                    } else {
                        Text("Almacenado y enviado por FULL")
                            .frame(alignment: .leading)
                            .font(.callout)
                            .foregroundColor(.green)
                    }
                    
                    if viewModel.description?.plainText != .empty
                        && viewModel.description?.plainText != nil {
                        Divider()
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Descripción")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.vertical)
                            Text(viewModel.description?.plainText ?? "")
                                .foregroundColor(.black)
                        }
                    }
                    
                    Button(action: {
                        if let url = URL(string: viewModel.detail?.permalink ?? .empty) {
                            openURL(url)
                        }
                    }) {
                        Text("Comprar ahora")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .opacity(showDetailContent ? 1 : 0)
            }
        }
        .padding()
        .scrollIndicators(.hidden)
        .background{
            Color.white
                .opacity(showDetailContent ? 1 : 0)
                .ignoresSafeArea()
        }
        .onAppear{
            viewModel.fetchProductDetail(id: id)
            viewModel.fetchProductDescription(id: id)
            withAnimation(.easeInOut) {
                os_log("[ProductDetailView] navigate to product detail", log: OSLog.navigation, type: .info)
                showDetailContent = true
            }
        }
    }
    
    
    func pageView(with url: URL) -> some View {
        AsyncImage(url: url) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .matchedGeometryEffect(id: id + "IMAGE", in: animation)
            } else if phase.error != nil {
                Image(systemName: Constants.defaultImage)
                    .resizable()
                    .renderingMode(.original)
                    .tint(.white)
            } else {
                ActivityIndicator(size: 60, color: .yellow)
            }
        }
    }

}
