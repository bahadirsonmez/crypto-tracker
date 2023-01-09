//
//  MarketDataService.swift
//  CryptoTracker
//
//  Created by Bahadır Sönmez on 24.12.2022.
//

import Foundation
import Combine

class MarketDataService {
    
    private var globalData: GlobalData? = nil {
        didSet {
            self.marketData = globalData?.data
        }
    }
    @Published var marketData: MarketDataModel? = nil
    var marketDataSubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
    func getData() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketDataSubscription = NetworkingManager.getData(from: url)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedGlobalData) in
                self?.globalData = returnedGlobalData
                self?.marketDataSubscription?.cancel()
            })
    }
    
}
