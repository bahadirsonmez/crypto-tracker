//
//  UIApplication+Extensions.swift
//  CryptoTracker
//
//  Created by Bahadır Sönmez on 22.12.2022.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
