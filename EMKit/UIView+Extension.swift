

import Foundation
import UIKit

extension UIView {
    
    // This quickly applies a drop shadow to a view. You could pull out some of these
    // properties and make them parameters so it's more customizable when you call it.
    // However, I typically find that a shadow style is likely to be universal for a project.
    // I have masksToBounds on there so it can be used on a view with a cornerRadius.
    
    // How it's used: myView.setShadow()
    
    func setShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.35
        clipsToBounds = true
        layer.masksToBounds = false
    }
    
    
    // Sets the background of any view to a gradient.
    // How it's used: myView.setGradientBackground(top: .red, bottom: .blue)
    
    func setGradientBackground(top: UIColor, bottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        let colorTop = top.cgColor as CGColor
        let colorBottom = bottom.cgColor as CGColor
        
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    /**
     Returns the UIViewController object that manages the receiver.
     */
    public func viewController() -> UIViewController? {
        
        var nextResponder: UIResponder? = self
        
        repeat {
            nextResponder = nextResponder?.next
            
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            
        } while nextResponder != nil
        
        return nil
    }
}
