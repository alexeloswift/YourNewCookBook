//
//  UIViewController + Extension.swift
//  Your New CookBook
//
//  Created by Alexis Diaz on 12/13/21.
//

import Foundation
import UIKit


extension UIViewController {
    func mediumImpact() {
        let impactMedium = UIImpactFeedbackGenerator(style: .medium)
            impactMedium.impactOccurred()
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: identifier) as! Self
    }
}
