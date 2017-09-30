//
//  ModalFullScreenImageView.swift
//  Kirina
//
//  Created by Arash Kashi on 3/15/17.
//  Copyright © 2017 Arash Kashi. All rights reserved.
//

import Foundation
import UIKit



class ModalFullScreenImageView {
  
  weak var viewController: UIViewController?
  weak var imageView: UIImageView?
  
  
  lazy var gesture: UITapGestureRecognizer = {
    
    let gesture = UITapGestureRecognizer(target: self, action: #selector(showModal))
    return gesture
  }()
  
  init(viewController: UIViewController, imageView: UIImageView) {
    
    self.viewController = viewController
    self.imageView = imageView
    
    self.imageView?.addGestureRecognizer(self.gesture)
    self.imageView?.isUserInteractionEnabled = true
  }
  
  @objc func showModal() {
    
    guard let validImage = self.imageView?.image else { return }
    let vc = FullScreenImageModalViewController(image: validImage)
    vc.modalPresentationStyle = .fullScreen
    
    self.viewController?.present(vc, animated: true) {
      
    }
  }
  
  deinit {
    print("")
  }
}

class FullScreenImageModalViewController: UIViewController {
  
  lazy var imageview: UIImageView = {
    
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  lazy var dismissButton: UIButton = {
    
    let button = UIButton(type: UIButtonType.custom)
    button.addTarget(self, action: #selector(onDismissTapped), for: .touchUpInside)
    button.setImage(Cancel.image(), for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    self.view.backgroundColor = .black
    
    view.addSubview(imageview)
    
    imageview.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive     = true
    imageview.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive   = true
    imageview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    imageview.topAnchor.constraint(equalTo: self.view.topAnchor).isActive   = true
    
    view.addSubview(dismissButton)
    
    dismissButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
    dismissButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    dismissButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    dismissButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
  }
  
  @objc func onDismissTapped() {
    
    self.dismiss(animated: true) { }
  }
  
  init(image: UIImage) {
    
    super.init(nibName: nil, bundle: nil)
    
    imageview.image = image
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    print("")
  }
}

