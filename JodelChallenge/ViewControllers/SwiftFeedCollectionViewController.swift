//
//  SwiftFeedCollectionViewController.swift
//  JodelChallenge
//
//  Created by Arash K. on 2017-09-28.
//  Copyright © 2017 Jodel. All rights reserved.
//

import Foundation
import UIKit


class SwiftFeedCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var photos: [URL] = []
    
    var dataProvider = DataProvider<Photo>(operationMode: .UI)
    var dataProviderBG = DataProvider<Photo>(operationMode: .Data)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        FlickrApi.fetchPhotos { (photos, page, perPage, total, error) in
            
            self.dataProviderBG.delelteAll()
            
            self.photos = photos as! [URL]
            
            var count: Int16 = 1
            for url in self.photos {
                
                self.dataProviderBG.create(setupBlock: { (photo) in

                    photo.count = count
                    photo.urlInString = url.absoluteString
                }, completion: { (createdPhoto) in
                    count = count + 1
                    
                })
            }
            
            for index in self.photos.count + 1...Int(total) {
                
                self.dataProviderBG.create(setupBlock: { (photo) in
                    photo.urlInString = nil
                    photo.count = Int16(index)
                }, completion: { (createdPhoto) in
                    
                    if index == Int(total) {
                        
                        try? self.dataProviderBG.mainManagedContext.save()
                        DispatchQueue.main.async {
                            
                            try? self.dataProvider.fetchResultController.performFetch()
                        }
                    }
                })
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let validFetchController = self.dataProvider.fetchResultController else { return 0 }
        guard let validSections = validFetchController.sections else { return 0 }
        
        return validSections[section].numberOfObjects
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let photo = self.dataProvider.fetchResultController?.object(at: indexPath)
        
        if photo == nil {
            
            print("error")
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! SwiftyCollectionCell
        
        cell.setupWith(photo: photo!)
        
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 sizeForItemAt indexPath: IndexPath) -> CGSize {
        var isPortraite = UIDevice.current.orientation == .portrait
        
        if isPortraite {
            
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height/2)
        } else {
            
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height/2)
        }
    }
}
