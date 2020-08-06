//
//  HomeViewModel.swift
//  GitHubRepositories
//
//  Created by Pedro Menezes on 04/08/20.
//  Copyright © 2020 Pedro Menezes. All rights reserved.
//

import Foundation

protocol HomeViewModelDelegate: class {
  func successInitalDataFetching()
  func successMoreDataFetching(indexPathsToReload: [IndexPath])
  func errorFetchingData(error: ServiceError)
}

final class HomeViewModel {
  
  // MARK: - Public properties
  
  weak var delegate: HomeViewModelDelegate?
  
  // MARK: - Class properties

  private var provider: HomeProviderDelegate
  private var isFetchInProgress = false
  private var currentPage = 1
  private var isFetchingMoreContent = false
  
  private var data: [RepositoryModel]  = []
  private var newData: [RepositoryModel] = []

  
  // MARK: - Init cycle

  init(coordinator: RootCoordinator, provider: HomeProviderDelegate) {
    self.provider = provider
  }
  
  // MARK: - Class methods
  
  private func successfullFetchingConfig() {
    if self.isFetchingMoreContent {
      self.data.append(contentsOf: self.newData)
      let indexPathsToReload = self.calculateIndexPathsToReload()
      self.delegate?.successMoreDataFetching(indexPathsToReload: indexPathsToReload)
    } else {
      self.data = self.newData
      self.delegate?.successInitalDataFetching()
    }
  }
  
  private func calculateIndexPathsToReload() -> [IndexPath] {
    let startIndex = self.data.count - self.newData.count
    let endIndex = startIndex + self.newData.count
    return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
  }

  // MARK: - Public methods
  
  func countData() -> Int {
    return self.data.count
  }
  
  func fetchData(isMoreContent: Bool) {
    guard !isFetchInProgress else {
      return
    }
    self.isFetchInProgress = true
    self.isFetchingMoreContent = isMoreContent
    self.currentPage = isMoreContent ? (self.currentPage + 1) : 1
    
    self.provider.getRepositories(page: self.currentPage, successCallBack: { [weak self] (response) in
      self?.newData = response.items ?? []
      self?.successfullFetchingConfig()
      self?.isFetchInProgress = false
    }) { [weak self] (error) in
      self?.delegate?.errorFetchingData(error: error)
      self?.isFetchInProgress = false
    }
  }
  
  func repositoryContent(index: Int) -> RepositoryModel? {
    guard self.data.indices.contains(index) else { return nil }
    return self.data[index]
  }

}
