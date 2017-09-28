//
//  PhotosCoreData.swift
//  JodelChallenge
//
//  Created by Arash K. on 2017-09-28.
//  Copyright © 2017 Jodel. All rights reserved.
//

import Foundation
import CoreData



struct ContactMetaInfo: ResourceMetaInfo {
    
    /// The name of the momd file.
    var coreStoreModelName      : String { return "Photos" }
    
    /// The name of the sqlite file.
    var coreStoreSQLiteFilename : String {
        
        if isRunningTests() {
            
            return "\(coreStoreModelName)Test.sqlite"
        } else {
            
            return "Photos.sqlite"
        }
    }
    
    /// The name of the entity in the model file.
    var entityName: String {
        
        return "Photo"
    }
}



extension Photo: CoreStorable {
    
    static var metaInfo: ResourceMetaInfo {
        
        return ContactMetaInfo()
    }
    
    static var fetchRequestWithDescriptor: NSFetchRequest<Photo> {
        
        let request = NSFetchRequest<Photo>(entityName: "Photo")
        
        let departmentSort = NSSortDescriptor(key: "count", ascending: true)
        
        request.sortDescriptors = [departmentSort]
        
        return request
    }
}
