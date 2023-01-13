//
//  CoingeckoEndpoint.swift
//  CryptoTracker
//
//  Created by Bahadır Sönmez on 10.01.2023.
//

import Foundation

struct CoingeckoEndpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension CoingeckoEndpoint {
    func getUrl() throws -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.coingecko.com"
        components.path = "/api/v3" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            throw NetworkingManager.NetworkingError.invalid
        }
        
        return url
    }
    
    var headers: [String: Any] {
        return [:]
    }
}

extension CoingeckoEndpoint {
    
    static func getCoinsData(by page: Int = 1) -> Self {
        return CoingeckoEndpoint(path: "/coins/markets",
                                 queryItems: [
                                    URLQueryItem(name: "vs_currency", value: "usd"),
                                    URLQueryItem(name: "order", value: "market_cap_desc"),
                                    URLQueryItem(name: "per_page", value: "250"),
                                    URLQueryItem(name: "page", value: "\(page)"),
                                    URLQueryItem(name: "sparkline", value: "true"),
                                    URLQueryItem(name: "price_change_percentage", value: "24h")
                                 ]
        )
    }
    
    static func getCoinDetailData(by id: String) -> Self {
        return CoingeckoEndpoint(path: "/coins/\(id)",
                                 queryItems: [
                                    URLQueryItem(name: "localization", value: "false"),
                                    URLQueryItem(name: "tickers", value: "false"),
                                    URLQueryItem(name: "market_data", value: "false"),
                                    URLQueryItem(name: "community_data", value: "false"),
                                    URLQueryItem(name: "developer_data", value: "false"),
                                    URLQueryItem(name: "sparkline", value: "false")
                                 ]
        )
    }
    
    static func getMarketData() -> Self {
        return CoingeckoEndpoint(path: "/global")
    }
    
}
