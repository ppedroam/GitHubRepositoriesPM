//
//  Dictionary.swift
//  GitHubRepositories
//
//  Created by Pedro Menezes on 04/08/20.
//  Copyright © 2020 Pedro Menezes. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

public extension Dictionary {
  
  func decode<T>(_ type: T.Type) -> T? where T : Decodable {
    if let jsonString = self.toString(),
      let jsonData = jsonString.data(using: .utf8),
      let objc = try? JSONDecoder().decode(type, from: jsonData) {
      return objc
    }
    return nil
  }
  
  func toString() -> String? {
    do {
      let data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
      return String(data: data, encoding: String.Encoding.utf8) ?? nil
    } catch {
      return nil
    }
  }
}
