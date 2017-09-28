//
//  SwiftFeedCollectionViewController.swift
//  JodelChallenge
//
//  Created by Arash K. on 2017-09-28.
//  Copyright © 2017 Jodel. All rights reserved.
//

import Foundation
import UIKit


class SwiftFeedCollectionViewController: UICollectionViewController {
    
    var photos: [URL] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        FlickrApi.fetchPhotos { (photos, page, perPage, total, error) in
            
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
            
            self.photos = photos as! [URL]
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
}
