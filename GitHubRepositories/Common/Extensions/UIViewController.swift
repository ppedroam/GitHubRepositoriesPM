//
//  UIViewController.swift
//  GitHubRepositories
//
//  Created by Pedro Menezes on 05/08/20.
//  Copyright © 2020 Pedro Menezes. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  func showAlertCommon(title: String, message: String?, handler: (() -> Void)?) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let btnOk = UIAlertAction(title: "Ok", style: .default, handler: { _ in
      handler?()
    })
    alert.addAction(btnOk)
    self.present(alert, animated: true, completion: nil)
  }
}
