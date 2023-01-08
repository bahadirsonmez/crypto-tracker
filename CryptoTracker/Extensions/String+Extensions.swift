//
//  String+Extensions.swift
//  CryptoTracker
//
//  Created by Bahadır Sönmez on 30.12.2022.
//

import Foundation

extension String {
        
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
