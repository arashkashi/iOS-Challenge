//
//  SwiftFeedCollectionViewModel.swift
//  JodelChallenge
//
//  Created by Arash K. on 2017-09-29.
//  Copyright © 2017 Jodel. All rights reserved.
//

import Foundation



class SwiftFeedCollectionViewModel {
  
  var dataProvider = DataProvider<Photo>(operationMode: .Data)
  
  // This functions fetches the first page upon the app start
  func getFreshData(completion: @escaping (Bool) -> () ) {
    
    FlickrApi.fetchPhotos { (photos, page, perPage, total, error) in
      
      self.dataProvider.delelteAll()
      
      guard error == nil else { completion(false); return }
      guard let validPhotos = photos as? [URL] else { completion(false); return }
      
      var count: Int16 = 1
      for url in validPhotos {
        
        self.dataProvider.create(setupBlock: { (photo) in
          
          photo.count = count
          photo.urlInString = url.absoluteString
        }, completion: { (createdPhoto) in
          count = count + 1
        })
      }
      
      for index in validPhotos.count + 1...Int(total) {
        
        self.dataProvider.create(setupBlock: { (photo) in
          photo.urlInString = nil
          photo.count = Int16(index)
        }, completion: { (createdPhoto) in
          
          if index == Int(total) {
            
            try? self.dataProvider.mainManagedContext.save()
            DispatchQueue.main.async { completion(true) }
          }
        })
      }
    }
  }
}
