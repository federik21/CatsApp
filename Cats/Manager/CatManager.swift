//
//  CatManager.swift
//  Cats
//
//  Created by federico piccirilli on 19/11/2024.
//

import Foundation
import CoreData

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
  let dataBaseContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext

  init(networkClient: CatNetworkService) {
    self.networkClient = networkClient

  }

  func getAllBreeds() async -> [CatBreed] {
    let catBreeds = try! await networkClient.getBreeds()
    for catBreed in catBreeds {
      cacheData(catBreed)
    }
    return catBreeds
  }

  func cacheData(_ catBreed: CatBreed) {
    let catEntity = CatBreedDB(context: dataBaseContext)
    catEntity.id = catBreed.id
    catEntity.name = catBreed.name
    catEntity.temperament = catBreed.temperament
    catEntity.origin = catBreed.origin
    catEntity.descriptionText = catBreed.description
    catEntity.lifeSpan = catBreed.lifeSpan
    catEntity.referenceImageId = catBreed.referenceImageID
    catEntity.favourite = false
    do {
      try dataBaseContext.save()
      print("Saved CatBreed successfully.")
    } catch {
      print("Failed to save CatBreed: \(error)")
    }
  }

  func getCatImageUrl(_ imageId: String) async -> URL {
    let catImage = try! await networkClient.getCatImage(id: imageId)
    return URL(string: catImage.url)!
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
