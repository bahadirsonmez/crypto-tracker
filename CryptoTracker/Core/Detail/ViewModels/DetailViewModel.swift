//
//  DetailViewModel.swift
//  CryptoTracker
//
//  Created by Bahadır Sönmez on 30.12.2022.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var coinDetail: CoinDetailModel?
    
    private let coin: CoinModel
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    func addSubscribers() {
        
        // updates coinDetail
        coinDetailService.$coinDetails
            .sink { [weak self] returnedCoinDetails in
                self?.coinDetail = returnedCoinDetails
            }
            .store(in: &cancellables)
        
    }
        
}
