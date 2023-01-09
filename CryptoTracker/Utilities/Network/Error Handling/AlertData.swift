//
//  AlertData.swift
//  CryptoTracker
//
//  Created by Bahadır Sönmez on 9.01.2023.
//

import SwiftUI

struct AlertData {
    let title: Text
    let message: Text?
    let dismissButton: Alert.Button?
    
    static let empty = AlertData(title: Text(""),
                                 message: nil,
                                 dismissButton: nil)
}
