//
//  MarketDataService.swift
//  CryptoTracker
//
//  Created by Bahadır Sönmez on 24.12.2022.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var marketData: MarketDataModel? = nil
    var marketDataSubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
    func getData() {
        do {
            let url = try CoingeckoEndpoint.getMarketData().getUrl()
            marketDataSubscription = NetworkingManager.getData(type: GlobalData.self, from: url)
                .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedGlobalData) in
                    self?.marketData = returnedGlobalData.data
                    self?.marketDataSubscription?.cancel()
                })
        } catch let error {
            AlertManager.postAlert(with: error)
        }
    }
    
}
