//
//  SwiftFeedCollectionViewController.swift
//  JodelChallenge
//
//  Created by Arash K. on 2017-09-28.
//  Copyright © 2017 Jodel. All rights reserved.
//

import Foundation
import UIKit
import CoreData


typealias PageInfo = (page: Int16, perPage: Int16)

class SwiftFeedCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  var dataProvider = DataProvider<Photo>(operationMode: .UI)
  
  var viewModel = SwiftFeedCollectionViewModel()
  var syncer: FetchResultsControllerWithCollectionView?
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    viewModel.getFreshData { (success) in }
    
    syncer = FetchResultsControllerWithCollectionView(fetchResultController: self.dataProvider.fetchResultController as! NSFetchedResultsController<NSManagedObject>,
                                                      collectionView: self.collectionView!)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    guard let validFetchController = self.dataProvider.fetchResultController else { return 0 }
    guard let validSections = validFetchController.sections else { return 0 }
    
    return validSections[section].numberOfObjects
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let photo = self.dataProvider.fetchResultController?.object(at: indexPath)
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! SwiftyCollectionCell
    
    cell.setupWith(photo: photo!)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let isPortraite = UIDevice.current.orientation == .portrait
    
    if isPortraite {
      
      return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height/2)
    } else {
      
      return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height/2)
    }
  }
  
  func fetchPhotosForVisibleCells() {
    
    guard let visibleCells = self.collectionView?.visibleCells as? [SwiftyCollectionCell] else {
      return
    }
    
    viewModel.updateVisibleCells(cells: visibleCells)
  }
  
  override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if decelerate == false {
      
      self.fetchPhotosForVisibleCells()
    }
  }
  
  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    
    self.fetchPhotosForVisibleCells()
  }
}



extension Collection where Iterator.Element == SwiftyCollectionCell {
  
  func pageInfo(total: Int16 = Int16.max) -> PageInfo? {
    
    let maxPerPage: Int16 = 20
    guard self.count != 0 else { return nil }
    
    let rows = self.map { $0.row }
    var min = rows.min()!
    var max = rows.max()!
    
    guard min < total && max < total else { return nil }
    
    max = [max, total].min()!
    
    max = [min + maxPerPage, max].min()!
    
    if min == 0 { return nil }
    if min == 1 { return (page: 1, perPage: [maxPerPage, total].min()!) }
    if min == max { max = min + [maxPerPage/2, total].min()! }
    
    var perPage = max - min
    var page = min / perPage

    while (min / perPage) * perPage + perPage < max || min % perPage == 0 {

      perPage = perPage + 1
      page = min / perPage
    }
    
    assert(perPage <= 60)
    return (page: page + 1, perPage: perPage)
  }
}



