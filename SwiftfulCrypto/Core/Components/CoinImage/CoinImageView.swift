//
//  CoinImageView.swift
//  SwiftfulCrypto
//
//  Created by adriano dlucca on 12/05/24.
//

import SwiftUI



struct CoinImageView: View {
    
    @StateObject var vm: CoinImageViewModel
    
    init(coin:CoinModel  ){
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack{
            if let image = vm.image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading{
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
    }
}

#Preview (traits: .sizeThatFitsLayout)  {
    CoinImageView(coin: DeveloperPreview.instance.coin)
        .padding()
}
