//
//  Double+Extension.swift
//  
//
//  Created by Pedro Anibarro on 6/18/18.
//

import Foundation

extension Double {
    
    // Rounds the double to decimal places value
    func roundTo(places: Int) -> Double {
        
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
        
    }
    
}
