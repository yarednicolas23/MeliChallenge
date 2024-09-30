//
//  SearcherProductGridCellView.swift
//  MeliChallenge
//
//  Created by Yared Nicolas Toro C on 29/09/24.
//


import SwiftUI

struct SearcherProductGridCellView: View {
    
    // MARK: - Public properties -
    @EnvironmentObject var appModel: AppViewModel
    var animation: Namespace.ID
    let item: ResultItem
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
            VStack(spacing: 4) {
                AsyncImage(url: item.itemImageURL()) { phase in
                    if let image = phase.image {
                        if appModel.currentItemSelected?.id == item.id && appModel.showDetailView {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 120, alignment: .leading)
                                .opacity(0)
                        } else {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .matchedGeometryEffect(id: item.id + "IMAGE", in: animation)
                        }
                        
                        /*
                        image
                            .resizable()
                            .renderingMode(.original)
                            .frame(height: 120, alignment: .trailing)
                         */
                    } else if phase.error != nil {
                        Image(systemName: Constants.defaultImage)
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 60, height: 60, alignment: .trailing)
                            .tint(.white)
                    } else {
                        ActivityIndicator(size: 40, color: .yellow)
                    }
                }.padding(EdgeInsets(top: .zero, leading: 10, bottom: 10, trailing: 10))
                
                
                Text(item.condition)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .matchedGeometryEffect(id: item.id + "CONDITION", in: animation)
                
                Text(item.title)
                    .font(.callout)
                    .fontWeight(.light)
                    .foregroundColor(.black)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .matchedGeometryEffect(id: item.id + "TITLE", in: animation)
                
                HStack {
                    Text(item.price.toCurrencyFormat())
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .frame(alignment: .leading)
                    
                    if let originalPrice = item.originalPrice {
                        Text(originalPrice.toCurrencyFormat())
                            .font(.caption2)
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Spacer()
                }
                // Envío gratis
                if item.shipping.freeShipping {
                    Text("Envío gratis")
                        .font(.caption)
                        .foregroundColor(.green)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Enviado por ⚡FULL")
                        .font(.caption2)
                        .foregroundColor(.green)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                } else {
                    Text("Enviado por ⚡FULL")
                        .font(.caption)
                        .foregroundColor(.green)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                // Promocionado
                Text("Promocionado")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(.top, 4)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                
                
            }
            .padding()
            .onTapGesture(perform: {
                withAnimation(.easeInOut){
                    appModel.currentItemSelected = item
                    appModel.showDetailView = true
                }
            })
        }
    }
}

struct Constants {
    static let defaultImage = "exclamationmark.triangle"
}
