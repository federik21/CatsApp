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
  func searchByBreed(_ breed: String) async
  func vote(breed: String, vote: Vote) async
}

class CatManager: CatManagerProtocol {

  var catBreeds = [CatBreed]()

  let networkClient: CatNetworkService

  init(networkClient: CatNetworkService) {
    self.networkClient = networkClient
  }

  func searchByBreed(_ breed: String) async {
    catBreeds = try! await networkClient.getCats(by: breed)
  }

  func getFavourites() async {
  }

  func vote(breed: String, vote: Vote) async {
  }
}
