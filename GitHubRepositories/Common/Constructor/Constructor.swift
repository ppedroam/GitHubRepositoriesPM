//
//  Constructor.swift
//  GitHubRepositories
//
//  Created by Pedro Menezes on 04/08/20.
//  Copyright © 2020 Pedro Menezes. All rights reserved.
//

import Foundation

protocol ConstructorDelegate {
  func makeInitialViewController(coordinator: ProjectCoordinator) -> HomeViewController
  func makeInitialViewModel(coordinator: RootCoordinator, provider: HomeProviderDelegate) -> HomeViewModel
}

class Constructor: ConstructorDelegate {
  
  func makeInitialViewController(coordinator: ProjectCoordinator) -> HomeViewController {
    let provider = HomeProvider()
    let viewModel = makeInitialViewModel(coordinator: coordinator, provider: provider)
    let initialViewController = HomeViewController(coordinator: coordinator, viewModel: viewModel)
    return initialViewController
  }
    
  func makeInitialCoordinator() -> ProjectCoordinator {
    let coordinator = ProjectCoordinator(factory: self)
    return coordinator
  }
  
  func makeInitialViewModel(coordinator: RootCoordinator, provider: HomeProviderDelegate) -> HomeViewModel {
    let viewModel = HomeViewModel(coordinator: coordinator, provider: provider)
    return viewModel
  }
}
