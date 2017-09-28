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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        FlickrApi.fetchPhotos { (photos, page, perPage, total, error) in
            
            self.photos = photos as! [URL]
            
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        
        cell.setup(withPhoto: self.photos[indexPath.row])
        
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
