//
//  URLRequest+Extension.swift
//
//
//  Created by Pedro Anibarro on 6/18/18.
//

import Foundation

extension UIApplication {

    /// Ask which view controller is on top
    ///
    /// - Returns: Top View Controller on screen
    func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            
            return topViewController(base: nav.visibleViewController)
            
        }
        
        if let tab = base as? UITabBarController {
            
            if let selected = tab.selectedViewController {
                
                return topViewController(base: selected)
                
            }
            
        }
        
        if let presented = base?.presentedViewController {
            
            return topViewController(base: presented)
            
        }
        
        return base
        
    }            

}
