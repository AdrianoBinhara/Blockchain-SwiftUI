//
//  CoinDataService.swift
//  SwiftfulCrypto
//
//  Created by adriano dlucca on 12/05/24.
//

import Foundation
import Combine

class CoinDataService{
    @Published var allCoins: [CoinModel] = []
    var coinSubscription: AnyCancellable?
    init(){
        getCoins()
    }
    
    
    private func getCoins(){
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let url = URL(string:
                                "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: decoder)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: {[weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })

        
    }

}
