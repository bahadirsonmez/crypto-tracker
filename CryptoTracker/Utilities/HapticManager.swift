//
//  HapticManager.swift
//  CryptoTracker
//
//  Created by Bahadır Sönmez on 28.12.2022.
//

import Foundation
import SwiftUI

class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
    
}
