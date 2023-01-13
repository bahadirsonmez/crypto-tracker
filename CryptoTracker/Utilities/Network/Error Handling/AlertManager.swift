//
//  AlertManager.swift
//  CryptoTracker
//
//  Created by Bahadır Sönmez on 9.01.2023.
//

import SwiftUI

final class AlertManager {
    
    static func postAlert(with error: Error) {
        NotificationCenter.default.post(name: .showAlert,
                                        object: AlertData(title: Text("Error"),
                                                          message: Text(error.localizedDescription),
                                                          dismissButton: .default(Text("OK")) {
            print("Alert dismissed")
        }))
    }

}
