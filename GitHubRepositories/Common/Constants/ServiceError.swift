//
//  File.swift
//  GitHubRepositories
//
//  Created by Pedro Menezes on 04/08/20.
//  Copyright © 2020 Pedro Menezes. All rights reserved.
//

import Foundation

//public enum ServiceError: Error {
//  static let parsing = NSError(domain: "parsingError", code: 0, userInfo: nil)
//  static let failure = NSError(domain: "failureError", code: 10, userInfo: nil)
//  static let wrongJson = NSError(domain: "wrongJsonError", code: 20, userInfo: nil)
//  static let noConnection = NSError(domain: "noConnection", code: 40, userInfo: nil)
//  static let invalidURL = NSError(domain: "noInternet", code: 50, userInfo: nil)
//
//}

public enum ServiceError: Error {
  case parsing
  case failure
  case noConnection
  case invalidURL
  
  var localizedDescription: String {
    switch self {
    case .parsing:
      return "SERVICE ERROR>>> Ocorreu erro de parse do json"
    case .failure:
      return "SERVICE ERROR>>> Ocorreu erro de comunicação com o serviço"
    case .noConnection:
      return "SERVICE ERROR>>> Ocorreu erro de internet"
    case .invalidURL:
      return "SERVICE ERROR>>> Ocorreu erro na criação da URL"
    }
  }
  
  var code: Int {
    switch self {
    case .parsing:
      return 10
    case .failure:
      return 20
    case .noConnection:
      return 30
    case .invalidURL:
      return 40
    }
  }
  
}
