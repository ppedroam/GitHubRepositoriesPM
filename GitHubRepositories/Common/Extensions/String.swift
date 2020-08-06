//
//  String.swift
//  GitHubRepositories
//
//  Created by Pedro Menezes on 06/08/20.
//  Copyright © 2020 Pedro Menezes. All rights reserved.
//

import Foundation

extension String {
  var parseJSONString: AnyObject? {
    let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
    if let jsonData = data {
      do {
        let message = try JSONSerialization.jsonObject(with: jsonData, options:.mutableContainers)
        return message as AnyObject
      } catch let error as NSError {
        print("An error occurred: \(error)")
        return nil
      }
    } else {
      return nil
    }
  }
  
  func decode<T>(_ type: T.Type) -> T? where T : Decodable {
    if let jsonData = self.data(using: .utf8),
      let objc = try? JSONDecoder().decode(type, from: jsonData) {
      return objc
    }
    return nil
  }
}
