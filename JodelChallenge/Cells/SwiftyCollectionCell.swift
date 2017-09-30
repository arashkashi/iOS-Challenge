//
//  SwiftyCollectionCell.swift
//  JodelChallenge
//
//  Created by Arash K. on 2017-09-28.
//  Copyright © 2017 Jodel. All rights reserved.
//

import Foundation
import Kingfisher


class SwiftyCollectionCell: UICollectionViewCell {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet var activityIndicator: UIActivityIndicatorView!
  
  @IBOutlet var titleLabel: UILabel!
  var fullScreenImagePresenter: ModalFullScreenImageView?
  weak var collectionViewController: UICollectionViewController?
  
  var hasValidPicture = false
  var row: Int16 = 0
  
  override func awakeFromNib() {
    
    super.awakeFromNib()
    self.imageView.contentMode = .scaleAspectFill
    self.activityIndicator.hidesWhenStopped = true
  }
  
  override func prepareForReuse() {
    
    super.prepareForReuse()
    self.imageView.image = nil
    self.hasValidPicture = false
    self.activityIndicator.startAnimating()
    self.titleLabel.text = ""
  }
  
  func setupWith(photo: Photo) {
    
    if let validURLString = photo.urlInString,
      let validURL = URL(string: validURLString) {
      
      self.imageView.kf.setImage(with: validURL)
      self.hasValidPicture = true
      self.activityIndicator.stopAnimating()
    }
    
    if let validTitle = photo.title {
      self.titleLabel.text = validTitle
    } else {
      self.titleLabel.text = ""
    }
    
    self.row = photo.count
    
    if let validVC = self.collectionViewController,
      fullScreenImagePresenter == nil {
      
      fullScreenImagePresenter = ModalFullScreenImageView(viewController: validVC,
                                                          imageView: self.imageView)
    }
  }
}
