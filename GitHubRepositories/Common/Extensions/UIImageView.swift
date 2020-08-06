//
//  UIImageView.swift
//  GitHubRepositories
//
//  Created by Pedro Menezes on 04/08/20.
//  Copyright © 2020 Pedro Menezes. All rights reserved.
//
import Foundation
import UIKit
import SDWebImage

extension UIImageView {
  
  func cacheImageSDWebImage(from link: String?, contentMode: UIView.ContentMode, renderingMode: Bool = false, completion: (()->(Void))? ) {
    
    guard let link_ = link, let url = URL(string: link_) else { return }
    self.contentMode = .center
    self.backgroundColor = .lightGray
    let activity = UIActivityIndicatorView(frame: self.frame)
    activity.center = self.center
    activity.startAnimating()
    activity.tintColor = .blue
    self.addSubview(activity)
    
    self.sd_setImage(with: url, placeholderImage: nil) { (image, _, _, _) in
      DispatchQueue.main.async {
        activity.removeFromSuperview()
        self.contentMode = contentMode
        
        guard let image = image else {
          self.image = UIImage(named: "error")
          return
        }
        
        if renderingMode {
          self.image = image.withRenderingMode(.alwaysTemplate)
        } else {
          self.image = image
        }
      }
      
      completion?()
    }
  }
  
}
