//
//  CoreStorable.swift
//  CoreStore
//
//  Created by Arash Kashi on 12/13/16.
//  Copyright © 2016 Arash K. All rights reserved.
//

import Foundation
import CoreData



protocol CoreStorable {
  
  associatedtype T: NSManagedObject
  
  static var metaInfo: ResourceMetaInfo { get }
  
  static var fetchRequestWithDescriptor: NSFetchRequest<T> { get }
  
  static var fetchAllRequest: NSFetchRequest<T> { get }
}


extension CoreStorable  {
  
  static var fetchAllRequest: NSFetchRequest<T> {
    
    return NSFetchRequest<T>(entityName: Self.metaInfo.entityName)
  }
}


extension Photo {
  
  static func fetchRequest(count: Int16) -> NSFetchRequest<Photo> {
    
    let request = Photo.fetchRequestWithDescriptor
    let predicate = NSPredicate(format: "count == %i", count)
    NSLog("Fetch request count == %i", count)
    request.predicate = predicate
    return request
  }
}


