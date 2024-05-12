//
//  HomeView.swift
//  SwiftfulCrypto
//
//  Created by adriano dlucca on 11/05/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false
    
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            //Content layer
            VStack{
                homeHeader
                
                columnTitles
                
                if !showPortfolio{
                    allCoinsList
                }
                if showPortfolio{
                    portfolioCoinsList
                }
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

#Preview {
    NavigationView{
        HomeView()
            .navigationBarHidden(true)
    }
    .environmentObject(DeveloperPreview.instance.homeVM)

}

extension HomeView{
    private var homeHeader: some View{
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus": "info")
                .transaction { transaction in
                    transaction.animation = nil
                }
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .transaction { transaction in
                    transaction.animation = nil
                }
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 :0))
                .onTapGesture {
                    withAnimation(.spring()){
                        showPortfolio.toggle()
                    }
                }
            
        }.padding(.horizontal)
    }
    
    private var allCoinsList: some View{
        List{
            ForEach(vm.allCoins){
                coin in CoinRowView(coin:coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top:10, leading:0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
        .transition(.move(edge: .leading))
    }
    private var portfolioCoinsList: some View{
        List{
            ForEach(vm.portfolioCoins){
                coin in CoinRowView(coin:coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top:10, leading:0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
        .transition(.move(edge: .trailing))
    }
    
    private var columnTitles: some View{
        HStack{
            Text("Coin")
            Spacer()
            if showPortfolio{
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)

        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
