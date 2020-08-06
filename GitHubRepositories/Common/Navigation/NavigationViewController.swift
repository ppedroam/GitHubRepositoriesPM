//
//  NavigationViewController.swift
//  GitHubRepositories
//
//  Created by Pedro Menezes on 04/08/20.
//  Copyright © 2020 Pedro Menezes. All rights reserved.
//

// MARK: - Outlets
// MARK: - Class properties
// MARK: - Public properties
// MARK: - Init cycle
// MARK: - Life cycle
// MARK: - Class methods
// MARK: - Actions
// MARK: - Extensions

import UIKit

class NavigationViewController: UINavigationController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationBar.isTranslucent = false
    self.navigationBar.barTintColor = .blue
    self.navigationBar.tintColor = .white
    self.navigationBar.shadowImage = UIImage()
    self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
  }

}
