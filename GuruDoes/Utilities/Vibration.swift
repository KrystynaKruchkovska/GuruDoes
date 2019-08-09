//
//  Vibration.swift
//  GuruDoes
//
//  Created by Krystyna Kruchkovska on 8/9/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit


internal enum Vibration {
    case error
    case success
    case warning
    case light
    case medium
    case heavy
    case selection
    
    /// Start vibro
    internal func vibrate() {
        
        switch self {
        case .error:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            
        case .success:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
        case .warning:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
            
        case .light:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            
        case .medium:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            
        case .heavy:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
        case .selection:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
            
        }
    }
    
}
