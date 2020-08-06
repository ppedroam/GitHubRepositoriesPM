//
//  MockHomeViewModel.swift
//  GitHubRepositoriesTests
//
//  Created by Pedro Menezes on 05/08/20.
//  Copyright © 2020 Pedro Menezes. All rights reserved.
//

import Foundation

@testable import GitHubRepositories

class MockHomeProvider: HomeProviderDelegate {
  
  var shoulReturnError = false
  
  func getRepositories(page: Int, successCallBack: @escaping (HomeModel) -> Void, errorCallBack: @escaping (ServiceError) -> Void) {
    if shoulReturnError {
      errorCallBack(ServiceError.failure)
    } else {
      successCallBack(ConstantsHomeProvider.objects)
    }
    return
  }
}
