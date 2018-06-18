//
//  NSManagedObject+Extension.swift
//  
//
//  Created by Pedro Anibarro on 6/18/18.
//

import Foundation

extension NSManagedObject {
    
    func inContext<T: NSManagedObject>(_ context: NSManagedObjectContext) -> T? {
        
        let objectID = self.objectID
        return context.object(with: objectID) as? T
        
    }
    
}
