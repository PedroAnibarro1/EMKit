//
//  UIColor+Extension.swift
//  
//
//  Created by Pedro Anibarro on 6/18/18.
//

import Foundation

extension UIColor {
    
    public convenience init(hexString: String) {
        let r, g, b, a: CGFloat // swiftlint:disable:this identifier_name
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        // Default value
        self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
    }
    
}
