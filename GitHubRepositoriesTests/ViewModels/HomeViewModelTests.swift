//
//  GitHubRepositoriesTests.swift
//  GitHubRepositoriesTests
//
//  Created by Pedro Menezes on 04/08/20.
//  Copyright © 2020 Pedro Menezes. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable import GitHubRepositories

class HomeViewModelTests: QuickSpec {
  
  private var viewModel: HomeViewModel!
  private var provider: MockHomeProvider!
  
  override func spec() {
    beforeEach {
      let coordinator = Constructor().makeInitialCoordinator()
      let provider = MockHomeProvider()
      self.provider = provider
      self.viewModel = HomeViewModel(coordinator: coordinator, provider: provider)
    }
    
    
    fetchInitalDataWithSuccess()
    fetchMoreDataWithSuccess()
    errorDataFetch()
  }
  
  func fetchInitalDataWithSuccess() {
    describe("Lista de repositorios") {
      
      let repositoriesBooks = ConstantsHomeProvider.objects
      
      context("Dado que buscou uma lista inicial de repositorios com sucesso") {
        
        beforeEach {
          self.provider.shoulReturnError = false
          self.viewModel.fetchData(isMoreContent: false)
        }

        it("deve obter uma lista de com o número de repositorios do json") {
          expect(self.viewModel.countData()).to(equal(repositoriesBooks.items?.count))
        }
        
        it("deve retornar o name do objeto de acordo com o json recebido") {
          expect(self.viewModel.repositoryContent(index: 0)?.name).to(equal(repositoriesBooks.items?.first?.name))
        }
        
        it("deve retornar a imagem do objeto de acordo com o json recebido") {
          expect(self.viewModel.repositoryContent(index: 0)?.owner?.avatarURL).to(equal(repositoriesBooks.items?.first?.owner?.avatarURL))
        }
      }
    }
  }
  
  func fetchMoreDataWithSuccess() {
    describe("Lista de repositorios") {
      
      let repositoriesBooks = ConstantsHomeProvider.listTwentyRepositories
      
      context("Dado que buscou duas listas de repositorios com sucesso") {
        
        beforeEach {
          self.provider.shoulReturnError = false
          self.viewModel.fetchData(isMoreContent: false)
          self.viewModel.fetchData(isMoreContent: true)
        }
        
        it("deve obter uma lista de com o número de repositorios retornados nas duas chamadas") {
          expect(self.viewModel.countData()).to(equal(repositoriesBooks.count))
        }
        
        it("deve retornar o name do objeto de acordo com o json recebido") {
          expect(self.viewModel.repositoryContent(index: 15)?.name).to(equal(repositoriesBooks[15].name))
        }
        
        it("deve retornar a imagem do objeto de acordo com o json recebido") {
          expect(self.viewModel.repositoryContent(index: 15)?.owner?.avatarURL).to(equal(repositoriesBooks[15].owner?.avatarURL))
        }
      }
    }
  }
  
  func errorDataFetch() {
    describe("Lista de repositorios") {
      
      let repositoriesBooks: HomeModel = HomeModel(totalCount: 0, incompleteResults: false, items: [])
      
      context("Dado que buscou uma lista inicial de repositorios com sucesso") {
        
        beforeEach {
          self.provider.shoulReturnError = true
          self.viewModel.fetchData(isMoreContent: false)
        }
        
        it("deve obter uma lista de com o número de repositorios do json") {
          expect(self.viewModel.countData()).to(equal(repositoriesBooks.items?.count))
        }
        
        it("deve retornar o name do objeto de acordo com o json recebido") {
          expect(self.viewModel.repositoryContent(index: 0)?.name).to(beNil())
        }
        
        it("deve retornar a imagem do objeto de acordo com o json recebido") {
          expect(self.viewModel.repositoryContent(index: 0)?.owner?.avatarURL).to(beNil())
        }
      }
    }
  }
  
  override func tearDown() {
    provider = nil
    viewModel = nil
  }
}
