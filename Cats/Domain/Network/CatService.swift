//
//  CatService.swift
//  Cats
//
//  Created by federico piccirilli on 19/11/2024.
//

import Foundation

protocol CatServiceProtocol {
  func fetchCatImages(by string: String?) async throws -> [CatImage]
  func getCats(by breed: String) async throws -> [CatBreed]
  func addVote(vote: Int, id: String) async throws -> DefaultResponse
}

class CatNetworkService: BaseNetworkService<Router>, CatServiceProtocol {

  func fetchCatImages(by string: String?) async throws -> [CatImage] {
    return try await request([CatImage].self, router: .getCats)
  }

  func getCats(by breed: String) async throws -> [CatBreed] {
    return try await request([CatBreed].self, router: .getCat(breed: breed))
  }

  func addVote(vote: Int, id: String) async throws -> DefaultResponse {
    return try await request(DefaultResponse.self, router: .addVote(value: vote, id: id))
  }
}
