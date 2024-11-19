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

protocol CatManager {
  func getFavourites() -> CatImage
  func searchByBreed() -> CatImage
  func vote(breed: String, vote: Vote?)
}
