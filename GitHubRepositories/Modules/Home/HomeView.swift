//
//  HomeView.swift
//  GitHubRepositories
//
//  Created by Pedro Menezes on 04/08/20.
//  Copyright © 2020 Pedro Menezes. All rights reserved.
//

import UIKit

class HomeView: UIView {
  
  // MARK: - Class properties
  
  private let tableView = UITableView()
  private let labelError = UILabel()
  private let button = UIButton()
  private let activity = UIActivityIndicatorView()
  private let refreshControl = UIRefreshControl()
    
  enum Strings {
    static let errorMessage = "Não foi possível acessar a lista de repositórios"
    static let buttonTitle = "Atualizar"
  }
  
  // MARK: - Public properties
  
  weak var controller: HomeViewController?
    
  // MARK: - Public properties
  
  // MARK: - Init cycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.tableView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    self.activity.frame = self.tableView.frame
    self.activity.center = self.tableView.center
    self.labelError.frame = CGRect(x: 20, y: 20, width: self.frame.width-40, height: 100)
    self.button.frame = CGRect(x: 20, y: self.labelError.frame.maxY+20, width: self.frame.width-40, height: 50)
  }
  
  // MARK: - Class methods
  
  private func setup() {
    self.backgroundColor = .white
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.prefetchDataSource = self
    self.tableView.backgroundColor = .white
    self.tableView.contentInsetAdjustmentBehavior = .never
    self.tableView.separatorStyle = .none
    self.tableView.registerCell(HomeTableViewCell.className)
    self.tableView.showsVerticalScrollIndicator = false
    self.refreshControl.addTarget(self, action: #selector(updateTableView), for: .valueChanged)
    self.tableView.refreshControl = self.refreshControl
    self.labelError.numberOfLines = 0
    self.labelError.textColor = .gray
    self.labelError.textAlignment = .center
    self.labelError.text = Strings.errorMessage
    self.button.setTitle(Strings.buttonTitle, for: .normal)
    self.button.setTitleColor(.blue, for: .normal)
    self.button.addTarget(self, action: #selector(refresh), for: .touchUpInside)
    self.activity.style = .medium
    self.activity.tintColor = .blue
    self.activity.color = .blue
    self.activity.startAnimating()
    self.addSubview(self.labelError)
    self.addSubview(self.button)
    self.addSubview(self.tableView)
    self.addSubview(self.activity)
  }
  
  @objc
  private func updateTableView() {
    self.refreshControl.beginRefreshing()
    self.controller?.didUpdateTableView()
    
  }
  
  @objc
  private func refresh() {
    self.labelError.isHidden = true
    self.activity.isHidden = false
    self.activity.startAnimating()
    self.button.isHidden = true
    self.controller?.didUpdateTableView()
  }
  
  private func successfulScreen() {
    self.refreshControl.endRefreshing()
    self.activity.isHidden = true
    self.tableView.isHidden = false
    self.labelError.isHidden = true
  }
  
  // MARK: - Public methods
  
  func fetchingInitialData() {
    self.activity.isHidden = false
  }
  
  func successfulInititalDataFetching() {
    self.successfulScreen()
    self.tableView.reloadData()
  }
  
  func successfulMoreDataFetching(indexPathsToReload: [IndexPath]) {
    self.successfulScreen()
    self.tableView.insertRows(at: indexPathsToReload, with: .none)
  }
  
  func showErrorScreen() {
    self.refreshControl.endRefreshing()
    self.activity.isHidden = true
    self.tableView.isHidden = true
    self.labelError.isHidden = false
    self.button.isHidden = false
  }
}

// MARK: - Extensions

extension HomeView: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.controller?.numberOfRows ?? 0 
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let index = indexPath.row
    
    if let numberOfRows = self.controller?.numberOfRows,
      indexPath.row == numberOfRows {
      
      let cell = UITableViewCell()
      cell.backgroundColor = .white
      let loading = UIActivityIndicatorView()
      loading.center = cell.center
      loading.startAnimating()
      loading.color = .blue
      cell.addSubview(loading)
      return cell
    }
    
    let cell = self.tableView.dequeueReusableCell(ofType: HomeTableViewCell.self, for: indexPath)
    if let cellContent = self.controller?.contentCell(for: index) {
      cell.passData(cellContent)
    }
    return cell
  }
}

extension HomeView: UITableViewDataSourcePrefetching {
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    for index in indexPaths {
      guard let maxRow = self.controller?.numberOfRows, maxRow > 10 else { return }
      if index.row > maxRow - 10 {
        self.controller?.fetchMoreContent()
      }
    }
  }
}
