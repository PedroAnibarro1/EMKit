//
//  UIScrollView+Extension.swift
//  
//
//  Created by Pedro Anibarro on 6/18/18.
//

import Foundation

extension UIScrollView {
    func scrollToTop(duration: Double, delay: Double = 0.5) {
        UIView.animate(withDuration: duration, delay: delay, options: .allowUserInteraction, animations: {
            let topOffset = CGPoint(x: 0, y: -self.contentInset.top)
            self.setContentOffset(topOffset, animated: false)
        })
    }
    
    func scrollToBottom(duration: Double, delay: Double = 0.5) {
        if self.contentSize.height < self.bounds.size.height { return }
        
        UIView.animate(withDuration: duration, delay: delay, options: .allowUserInteraction, animations: {
            let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
            self.setContentOffset(bottomOffset, animated: false)
        })
    }
}
