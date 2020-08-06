//
//  HomeTableViewCell.swift
//  GitHubRepositories
//
//  Created by Pedro Menezes on 04/08/20.
//  Copyright © 2020 Pedro Menezes. All rights reserved.
//

import UIKit
import Cosmos

class HomeTableViewCell: UITableViewCell {
  
  override var reuseIdentifier: String? {
    return HomeTableViewCell.className
  }
  
  @IBOutlet weak var imageViewContent: UIImageView!
  @IBOutlet weak var labelTitle: UILabel!
  @IBOutlet weak var viewStars: CosmosView!
  @IBOutlet weak var labelAuthor: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.selectionStyle = .none
    self.viewStars.backgroundColor = .clear
    self.viewStars.isUserInteractionEnabled = false
    self.viewStars.settings.fillMode = .half
    self.viewStars.settings.filledBorderColor = .black
    self.viewStars.settings.emptyColor = .white
    self.viewStars.settings.emptyBorderColor = .black
  }
  
  func passData(_ data: RepositoryModel) {
    self.labelTitle.text = data.name
    self.viewStars.rating = Double(data.score ?? 0)
    self.imageViewContent.cacheImageSDWebImage(from: data.owner?.avatarURL, contentMode: .scaleAspectFill, completion: nil)
    self.labelAuthor.text = "By: \(data.owner?.login ?? "")"
  }
}
