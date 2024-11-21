//
//  CatManager.swift
//  Cats
//
//  Created by federico piccirilli on 19/11/2024.
//

import Foundation

enum Vote {
  case up, down, neutral
}

protocol CatManagerProtocol {
  func getFavourites() async
  func getAllBreeds() async -> [CatBreed]
  func searchByBreed(_ breed: String) async -> [CatBreed]
  func vote(breed: String, vote: Vote) async
}

actor CatManager: CatManagerProtocol {

  let networkClient: CatNetworkService
  let databaseClient: DatabaseService

  init(networkClient: CatNetworkService,
       databaseClient: DatabaseService) {
    self.networkClient = networkClient
    self.databaseClient = databaseClient
  }

  func getAllBreeds() async -> [CatBreed] {
    let catBreeds = try! await networkClient.getBreeds()
    for catBreed in catBreeds {
//      cacheData(catBreed)
    }
    return catBreeds
  }

  private func cacheData(_ catBreed: CatBreed) {
    databaseClient.cacheData(catBreed)
  }

  private func getCachedCatBreeds() -> [CatBreed] {
    databaseClient.getCachedCatBreeds()
  }

  func getCatImageUrl(_ imageId: String) async -> URL {
    let catImage = try! await networkClient.getCatImage(id: imageId)
    return URL(string: catImage.url)!
  }

  func searchByBreed(_ breed: String) async -> [CatBreed] {
//    try! await networkClient.getCats(by: breed)
    [CatBreed()]
  }

  func getFavourites() async {
  }

  func vote(breed: String, vote: Vote) async {
  }
}
