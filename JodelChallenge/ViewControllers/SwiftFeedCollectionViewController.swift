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
    
    var dataProvider = DataProvider<Photo>(operationMode: .UI)
    var dataProviderBG = DataProvider<Photo>(operationMode: .Data)
    
    var viewModel = SwiftFeedCollectionViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        viewModel.getFreshData { (success) in }
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
