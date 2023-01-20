//
//  CoinDetailDataService.swift
//  CryptoTracker
//
//  Created by Bahadır Sönmez on 30.12.2022.
//

import Foundation
import Combine

class CoinDetailDataService {
    
    @Published var coinDetails: CoinDetailModel?
    
    var coinDetailSubscription: AnyCancellable?
    private let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails() {
        do {
            let url = try CoingeckoEndpoint.getCoinDetailData(by: coin.id).getUrl()
            coinDetailSubscription = NetworkingManager.getData(type: CoinDetailModel.self, from: url)
                .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoinDetails) in
                    self?.coinDetails = returnedCoinDetails
                    self?.coinDetailSubscription?.cancel()
                })
        } catch let error {
            AlertManager.postAlert(with: error)
        }
    }
    
}
