//
//  DatabaseService.swift
//  Cats
//
//  Created by federico piccirilli on 20/11/2024.
//

import Foundation
import CoreData

protocol DatabaseService {
  func cacheData(_ catBreed: CatBreed)
  func getCachedCatBreeds() -> [CatBreed]
}

class CoredataService: DatabaseService {
  let dataBaseContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext

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
    } catch {
      print("Failed to save CatBreed: \(error)")
    }
  }

  func getCachedCatBreeds() -> [CatBreed] {
    let fetchRequest: NSFetchRequest<CatBreedDB> = CatBreedDB.fetchRequest()
    do {
      let cats = try dataBaseContext.fetch(fetchRequest)
      var results = [CatBreed]()
      for entity in cats {
        results.append(CatBreed(from: entity))
      }
      return results
    } catch {
      print("Failed to fetch CatBreeds: \(error)")
      return []
    }
  }
}
extension CatBreed {
  init(from catEntity: CatBreedDB) {
    self.id = catEntity.id
    self.name = catEntity.name
    self.temperament = catEntity.temperament
    self.origin = catEntity.origin
    self.description = catEntity.descriptionText
    self.lifeSpan = catEntity.lifeSpan
    self.referenceImageID = catEntity.referenceImageId
  }
}
