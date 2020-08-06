//
//  HomeProvider.swift
//  GitHubRepositories
//
//  Created by Pedro Menezes on 04/08/20.
//  Copyright © 2020 Pedro Menezes. All rights reserved.
//

import Foundation

protocol HomeProviderDelegate {
  func getRepositories(page: Int, successCallBack: @escaping (HomeModel) -> Void, errorCallBack: @escaping (ServiceError) -> Void)
}

class HomeProvider: HomeProviderDelegate {
  func getRepositories(page: Int, successCallBack: @escaping (HomeModel) -> Void, errorCallBack: @escaping (ServiceError) -> Void) {
    let urlString = SharedUrls.gitHubRepositories.replacingOccurrences(of: "#PAGE", with: "\(page)", options: .literal, range: nil)
  
    guard let url = URL(string: urlString) else {
      errorCallBack(ServiceError.invalidURL)
      return
    }
    
    guard Connectivity.isConnectedToInternet else {
      errorCallBack(ServiceError.noConnection)
      return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      if let _ = error {
        errorCallBack(ServiceError.failure)
        return
      }
      
      if let response = response as? HTTPURLResponse {
        print("Response HTTP Status code: \(response.statusCode)")
      }
      
      if let data = data,
        let json = GenericFunctions.dataToDictionary(data),
        let model = json.decode(HomeModel.self) {
          successCallBack(model)
      } else {
        errorCallBack(ServiceError.parsing)
      }
      return
    }
    task.resume()
  }
}
