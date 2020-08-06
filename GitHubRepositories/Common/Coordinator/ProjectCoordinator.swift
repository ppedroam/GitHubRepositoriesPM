//
//  ProjectCoordinator.swift
//  MVCC
//
//  Created by Steven Curtis on 02/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

protocol RootCoordinator: class {
  func start(_ navigationController: UINavigationController)
}

protocol AbstractCoordinator {
  func addChildCoordinator(_ coordinator: AbstractCoordinator)
  func removeAllChildCoordinatorsWith<T>(type: T.Type)
  func removeAllChildCoordinators()
}

class ProjectCoordinator: AbstractCoordinator, RootCoordinator {

  private(set) var childCoordinators: [AbstractCoordinator] = []
  private var factory: ConstructorDelegate
  
  weak var navigationController: UINavigationController?
  
  init(factory: ConstructorDelegate) {
    self.factory = factory
  }
  
  func addChildCoordinator(_ coordinator: AbstractCoordinator) {
    self.childCoordinators.append(coordinator)
  }
  
  func removeAllChildCoordinatorsWith<T>(type: T.Type) {
    self.childCoordinators = childCoordinators.filter { $0 is T  == false }
  }
  
  func removeAllChildCoordinators() {
    self.childCoordinators.removeAll()
  }
  
  func start(_ navigationController: UINavigationController) {
    let initialViewController = factory.makeInitialViewController(coordinator: self)
    self.navigationController = navigationController
    navigationController.pushViewController(initialViewController, animated: true)
  }
}



