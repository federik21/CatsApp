//
//  CatService.swift
//  Cats
//
//  Created by federico piccirilli on 19/11/2024.
//

import Foundation

protocol CatServiceProtocol {
  func fetchCats(by string: String?) async throws -> Cat
}

class NetworkService: BaseNetworkService<Router>, CatServiceProtocol {

  func fetchCats(by string: String?) async throws -> Cat {
    return try await request(Cat.self, router: .getCats)
  }
}
