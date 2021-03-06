//
//  UnicodeScalar+Extension.swift
//  
//
//  Created by Pedro Anibarro on 6/18/18.
//

import Foundation

extension UnicodeScalar {
    
    var isEmoji: Bool {
        
        switch value {
        case 0x3030, 0x00AE, 0x00A9, // Special Characters
        0x1D000...0x1F77F,           // Emoticons
        0x2100...0x27BF,             // Misc symbols and Dingbats
        0xFE00...0xFE0F,             // Variation Selectors
        0x1F900...0x1F9FF:           // Supplemental Symbols and Pictographs
            return true
            
        default: return false
        }
    }
    
    var isZeroWidthJoiner: Bool {
        
        return value == 8205
    }
}
