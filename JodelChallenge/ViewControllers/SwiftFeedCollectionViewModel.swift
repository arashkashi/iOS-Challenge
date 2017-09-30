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
  
  func updateVisibleCells(cells: [SwiftyCollectionCell]) {
    
    let tt: [SwiftyCollectionCell] = cells.filter{$0.hasValidPicture == false}
    guard let pageInfo = tt.pageInfo() else { return }
    
    FlickrApi.fetchPhotos(forPage: "\(pageInfo.page)",
                          perPage: "\(pageInfo.perPage)")
    { [weak self] (photos, page, perPage, total, error) in
      
      guard let validPhotos = photos as? [URL] else { return }
      
      var counter = 0
      for (index, fetchedPhoto) in validPhotos.enumerated() {
        
        let row = (page - 1) * perPage + UInt(index) + 1
        
        self?.dataProvider.fetch(fetchRequest: Photo.fetchRequest(count: Int16(row))
          , completion: { (fetched) in
            guard let validFetch = fetched else { return }
            assert(validFetch.count == 1)
            validFetch.first?.urlInString = fetchedPhoto.absoluteString
            counter = counter + 1
            
            if counter == validPhotos.count {
              try? self?.dataProvider.mainManagedContext.save()
              NSLog("saved after stopping")
            }
        })
      }
    }
  }
  
  // This functions fetches the first page upon the app start
  func getFreshData(completion: @escaping (Bool) -> () ) {
    
    FlickrApi.fetchPhotos(forPage: "1", perPage: "10") { [weak self] (photos, page, perPage, total, error) in
      
      guard error == nil else { completion(false); return }
      guard let validPhotos = photos as? [URL] else { completion(false); return }
      
      self?.dataProvider.delelteAll()
      
      var count: Int16 = 1
      for url in validPhotos {
        
        self?.dataProvider.create(setupBlock: { (photo) in
          
          photo.count = count
          photo.urlInString = url.absoluteString
        }, completion: { (createdPhoto) in
          count = count + 1
        })
      }
      
      for index in validPhotos.count + 1...Int(total) {
        
        self?.dataProvider.create(setupBlock: { (photo) in
          photo.urlInString = nil
          photo.count = Int16(index)
        }, completion: { (createdPhoto) in
          
          if index == Int(total) {
            
            try? self?.dataProvider.mainManagedContext.save()
            DispatchQueue.main.async { completion(true) }
          }
        })
      }
    }
  }
}
