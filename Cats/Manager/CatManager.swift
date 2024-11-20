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

class CatManager: CatManagerProtocol {

  let networkClient: CatNetworkService

  init(networkClient: CatNetworkService) {
    self.networkClient = networkClient
  }

  func getAllBreeds() async -> [CatBreed] {
    try! await networkClient.getBreeds()
  }

  func searchByBreed(_ breed: String) async -> [CatBreed] {
//    try! await networkClient.getCats(by: breed)
    []
  }

  func getFavourites() async {
  }

  func vote(breed: String, vote: Vote) async {
  }
}
