//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by adriano dlucca on 11/05/24.
//

import Foundation
import Combine
class HomeViewModel: ObservableObject{
 
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init(){
       addSubscribers()
    }
    
    func addSubscribers(){
        dataService.$allCoins
            .sink {[weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
}
