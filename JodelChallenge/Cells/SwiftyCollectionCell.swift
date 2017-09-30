//
//  SwiftyCollectionCell.swift
//  JodelChallenge
//
//  Created by Arash K. on 2017-09-28.
//  Copyright © 2017 Jodel. All rights reserved.
//

import Foundation

class SwiftyCollectionCell: UICollectionViewCell {
  
  @IBOutlet weak var imageView: UIImageView!
  
  var hasValidPicture = false
  var row: Int16 = 0
  
  override func awakeFromNib() {
    
    super.awakeFromNib()
    self.imageView.contentMode = .scaleAspectFit
    self.imageView.image = Add.image(frame: self.imageView.frame, resizing: .aspectFit)
  }
  
  override func prepareForReuse() {
    
    super.prepareForReuse()
    self.imageView.image = Add.image(frame: self.imageView.frame, resizing: .aspectFit)
    self.hasValidPicture = false
  }
  
  func setupWith(photo: Photo) {
    
    if let validURLString = photo.urlInString,
      let validURL = URL(string: validURLString) {
      
//      self.imageView.setImageWith(validURL)
      self.hasValidPicture = true
    }
    
    self.row = photo.count
  }
}
