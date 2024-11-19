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
  func searchByBreed() async
  func vote(breed: String, vote: Vote) async
}

class CatManager: CatManagerProtocol {

  var cats = [CatImage]()

  let networkClient: CatNetworkService

  init(networkClient: CatNetworkService) {
    self.networkClient = networkClient
  }

  func getFavourites() async {
    cats = try! await networkClient.fetchCatImages(by: nil)
  }

  func searchByBreed() async {
    cats = try! await networkClient.fetchCatImages(by: nil)
  }

  func vote(breed: String, vote: Vote) async {
    var voteInt = 0
    switch vote {
    case .up:
      voteInt = 1
    case .down:
      voteInt = -1
    case .neutral:
      voteInt = 0
    }
    _ = try? await networkClient.addVote(vote: voteInt, id: breed)
  }


}
