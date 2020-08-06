//
//  TableView.swift
//  GitHubRepositories
//
//  Created by Pedro Menezes on 04/08/20.
//  Copyright © 2020 Pedro Menezes. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
  
  func registerCell(_ identifier: String) {
    self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
  }
  
  func dequeueReusableCell<T: UITableViewCell>(ofType type: T.Type, for indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: type.className, for: indexPath) as? T else {
      fatalError("Couldn't find UITableViewCell of class \(type.className)")
    }
    return cell
  }
}
