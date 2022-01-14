//
//  UIViewController + Extension.swift
//  Your New CookBook
//
//  Created by Alexis Diaz on 12/13/21.
//

import Foundation
import UIKit


// HAPTICS

extension UIViewController {
    
    func mediumImpact() {
        let impactMedium = UIImpactFeedbackGenerator(style: .medium)
            impactMedium.impactOccurred()
    }
    
//    DECLARING IDENTIFIER FOR IB
    
    static var identifier: String {
        return String(describing: self)
    }
    
//    INSTANTIATING IB
    
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: identifier) as! Self
    }
}

