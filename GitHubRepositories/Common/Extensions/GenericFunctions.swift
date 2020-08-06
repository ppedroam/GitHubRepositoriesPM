//
//  GenericFunctions.swift
//  GitHubRepositories
//
//  Created by Pedro Menezes on 04/08/20.
//  Copyright © 2020 Pedro Menezes. All rights reserved.
//

import Foundation

class GenericFunctions {
  static func dataToDictionary(_ data: Data) -> [String : Any]? {
    do {
      let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any]
      return json
    } catch let myJSONError {
      print(myJSONError)
    }
    return nil
  }
}
