//
//  CoinDataService.swift
//  CryptoTracker
//
//  Created by Bahadır Sönmez on 20.12.2022.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allCoins: [CoinModel] = []
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    func getCoins() {
        do {
            let url = try CoingeckoEndpoint.getCoinsData().getUrl()
            coinSubscription = NetworkingManager.getData(type: [CoinModel].self, from: url)
                .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                    self?.allCoins = returnedCoins
                    self?.coinSubscription?.cancel()
                })
        } catch let error {
            AlertManager.postAlert(with: error)
        }
    }
    
}
