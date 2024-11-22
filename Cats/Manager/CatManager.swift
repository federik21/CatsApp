//
//  CatManager.swift
//  Cats
//
//  Created by federico piccirilli on 19/11/2024.
//

import Foundation

protocol CatManagerProtocol {
  func getAllBreeds() async -> [CatItemModel]
  func getFavourites() async -> Set<String>
  func setFavourite(_ id: String, _ favourite: Bool) async
}

actor CatManager: CatManagerProtocol {

  let networkClient: CatNetworkService
  let databaseClient: DatabaseService

  init(networkClient: CatNetworkService,
       databaseClient: DatabaseService) {
    self.networkClient = networkClient
    self.databaseClient = databaseClient
  }

  func getAllBreeds() async -> [CatItemModel] {
    var cats = [CatBreed]()
    if let catBreeds = try? await networkClient.getBreeds() {
      for catBreed in catBreeds {
        await cacheData(catBreed)
      }
      cats = catBreeds
    } else {
      cats = await getCachedCatBreeds()
    }
    return cats.map{CatItemModel(id: $0.id ?? "",
                                 name: $0.name ?? "Unknow",
                                 origin: $0.origin ?? "Unknow",
                                 lifeSpan: $0.lifeSpan ?? "Unknow",
                                 temperament: $0.temperament ?? "Unknow",
                                 description: $0.description ?? "Unknow",
                                 picUrl: $0.image?.url ?? "")}
  }

  private func cacheData(_ catBreed: CatBreed) async {
    await databaseClient.cacheData(catBreed)
  }

  private func getCachedCatBreeds() async ->  [CatBreed]  {
    await databaseClient.getCachedCatBreeds()
  }

  func getCatImageUrl(_ imageId: String) async -> URL? {
    if let catImage = try? await networkClient.getCatImage(id: imageId) {
      return URL(string: catImage.url)
    }
    return nil
  }

  func getFavourites() async -> Set<String> {
    Set(await databaseClient.getFavouriteCatBreeds())
  }

  func setFavourite(_ id: String, _ favourite: Bool) async {
    await databaseClient.toggleFavorite(id, favourite)
  }
}
