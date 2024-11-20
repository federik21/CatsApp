//
//  CatBreed.swift
//  Cats
//
//  Created by federico piccirilli on 19/11/2024.
//

import Foundation

struct CatBreed: Codable {
  struct Weight: Codable {
    let imperial: String?
    let metric: String?
  }

  var weight: Weight?
  var id: String?
  var name: String?
  var cfaURL: String?
  var vetstreetURL: String?
  var vcahospitalsURL: String?
  var temperament: String?
  var origin: String?
  var countryCodes: String?
  var countryCode: String?
  var description: String?
  var lifeSpan: String?
  var indoor: Int?
  var lap: Int?
  var altNames: String?
  var adaptability: Int?
  var affectionLevel: Int?
  var childFriendly: Int?
  var dogFriendly: Int?
  var energyLevel: Int?
  var grooming: Int?
  var healthIssues: Int?
  var intelligence: Int?
  var sheddingLevel: Int?
  var socialNeeds: Int?
  var strangerFriendly: Int?
  var vocalisation: Int?
  var experimental: Int?
  var hairless: Int?
  var natural: Int?
  var rare: Int?
  var rex: Int?
  var suppressedTail: Int?
  var shortLegs: Int?
  var wikipediaURL: String?
  var hypoallergenic: Int?
  var referenceImageID: String?

  enum CodingKeys: String, CodingKey {
    case weight
    case id
    case name
    case cfaURL = "cfa_url"
    case vetstreetURL = "vetstreet_url"
    case vcahospitalsURL = "vcahospitals_url"
    case temperament
    case origin
    case countryCodes = "country_codes"
    case countryCode = "country_code"
    case description
    case lifeSpan = "life_span"
    case indoor
    case lap
    case altNames = "alt_names"
    case adaptability
    case affectionLevel = "affection_level"
    case childFriendly = "child_friendly"
    case dogFriendly = "dog_friendly"
    case energyLevel = "energy_level"
    case grooming
    case healthIssues = "health_issues"
    case intelligence
    case sheddingLevel = "shedding_level"
    case socialNeeds = "social_needs"
    case strangerFriendly = "stranger_friendly"
    case vocalisation
    case experimental
    case hairless
    case natural
    case rare
    case rex
    case suppressedTail = "suppressed_tail"
    case shortLegs = "short_legs"
    case wikipediaURL = "wikipedia_url"
    case hypoallergenic
    case referenceImageID = "reference_image_id"
  }
}
