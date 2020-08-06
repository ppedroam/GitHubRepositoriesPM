//
//  ViewController.swift
//  GitHubRepositories
//
//  Created by Pedro Menezes on 04/08/20.
//  Copyright © 2020 Pedro Menezes. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  
  // MARK: - Class properties

  private var coordinator: ProjectCoordinator
  private var customView: HomeView?
  private var viewModel: HomeViewModel
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
    
  // MARK: - Public properties
  
  var numberOfRows: Int = 0
  
  // MARK: - Init cycle

  init(coordinator: ProjectCoordinator, viewModel: HomeViewModel) {
    self.coordinator = coordinator
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.viewModel.delegate = self
    self.title = "GitHub Repos"
    self.fetchData(false)
  }
  
  override func loadView() {
    let homeView = HomeView()
    homeView.controller = self
    self.customView = homeView
    self.view = homeView
  }
  
  // MARK: - Class methods
  
  private func fetchData(_ isFetchingMoreContent: Bool) {
    if !isFetchingMoreContent{ self.customView?.fetchingInitialData() }
    self.viewModel.fetchData(isMoreContent: isFetchingMoreContent)
  }
  
  private func changeCountOfRepos() {
    let total = self.viewModel.countData()
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Total: \(total)", style: UIBarButtonItem.Style.plain, target: self, action: nil)
    self.navigationItem.rightBarButtonItem?.tintColor = .white
  }
  
  private func refreshNumberOfRows() {
    let numberOfRows = self.viewModel.countData() > 0 ? (self.viewModel.countData() + 1) : 0
    self.numberOfRows = numberOfRows
  }
  
  // MARK: Public methods
  
  func fetchMoreContent() {
    self.fetchData(true)
  }
  
  func didUpdateTableView() {
    self.fetchData(false)
  }
  
  func contentCell(for indexPath: Int) -> RepositoryModel? {
    return self.viewModel.repositoryContent(index: indexPath)
  }
}

// MARK: - Extensions

extension HomeViewController: HomeViewModelDelegate {
  func successInitalDataFetching() {
    DispatchQueue.main.async {
      self.changeCountOfRepos()
      self.refreshNumberOfRows()
      self.customView?.successfulInititalDataFetching()
    }
  }
  
  func successMoreDataFetching(indexPathsToReload: [IndexPath]) {
    DispatchQueue.main.async {
      self.changeCountOfRepos()
      self.refreshNumberOfRows()
      self.customView?.successfulMoreDataFetching(indexPathsToReload: indexPathsToReload)
    }
  }
  
  func errorFetchingData(error: ServiceError) {
    DispatchQueue.main.async {
      print(error.localizedDescription)
      self.customView?.showErrorScreen()
      
      if error.code == ServiceError.noConnection.code {
        self.showAlertCommon(title: "Sem conexão à internet", message: nil, handler: nil)
      }
    }
  }
}

