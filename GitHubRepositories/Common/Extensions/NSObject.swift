//
//  NSObject.swift
//  GitHubRepositories
//
//  Created by Pedro Menezes on 04/08/20.
//  Copyright © 2020 Pedro Menezes. All rights reserved.
//

import Foundation

extension NSObject {
  static var className: String {
    return String(describing: self)
  }
}
