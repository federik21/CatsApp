//
//  ManagerTests.swift
//  CatsTests
//
//  Created by federico piccirilli on 19/11/2024.
//

import Foundation
import XCTest

class ManagerTests: XCTestCase {

  var client: CatNetworkService!
  var manager: CatManager!

  override func setUp() {
    client = CatNetworkService(urlSession: {
      let configuration: URLSessionConfiguration = .ephemeral
      configuration.protocolClasses = [MockURLProtocol.self]
      return URLSession(configuration: configuration)
    }())

    manager = CatManager(networkClient: client)
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testGetBreed () {
    let jsonData = """
  [
  {
    "weight": {
      "imperial": "7  -  10",
      "metric": "3 - 5"
    },
    "id": "abys",
    "name": "Abyssinian",
    "cfa_url": "http://cfa.org/Breeds/BreedsAB/Abyssinian.aspx",
    "vetstreet_url": "http://www.vetstreet.com/cats/abyssinian",
    "vcahospitals_url": "https://vcahospitals.com/know-your-pet/cat-breeds/abyssinian",
    "temperament": "Active, Energetic, Independent, Intelligent, Gentle",
    "origin": "Egypt",
    "country_codes": "EG",
    "country_code": "EG",
    "description": "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.",
    "life_span": "14 - 15",
    "indoor": 0,
    "lap": 1,
    "alt_names": "",
    "adaptability": 5,
    "affection_level": 5,
    "child_friendly": 3,
    "dog_friendly": 4,
    "energy_level": 5,
    "grooming": 1,
    "health_issues": 2,
    "intelligence": 5,
    "shedding_level": 2,
    "social_needs": 5,
    "stranger_friendly": 5,
    "vocalisation": 1,
    "experimental": 0,
    "hairless": 0,
    "natural": 1,
    "rare": 0,
    "rex": 0,
    "suppressed_tail": 0,
    "short_legs": 0,
    "wikipedia_url": "https://en.wikipedia.org/wiki/Abyssinian_(cat)",
    "hypoallergenic": 0,
    "reference_image_id": "0XYvRd7oD"
  },
  {
    "weight": {
      "imperial": "7 - 10",
      "metric": "3 - 5"
    },
    "id": "aege",
    "name": "Aegean",
    "vetstreet_url": "http://www.vetstreet.com/cats/aegean-cat",
    "temperament": "Affectionate, Social, Intelligent, Playful, Active",
    "origin": "Greece",
    "country_codes": "GR",
    "country_code": "GR",
    "description": "Native to the Greek islands known as the Cyclades in the Aegean Sea, these are natural cats, meaning they developed without humans getting involved in their breeding. As a breed, Aegean Cats are rare, although they are numerous on their home islands. They are generally friendly toward people and can be excellent cats for families with children.",
    "life_span": "9 - 12",
    "indoor": 0,
    "alt_names": "",
    "adaptability": 5,
    "affection_level": 4,
    "child_friendly": 4,
    "dog_friendly": 4,
    "energy_level": 3,
    "grooming": 3,
    "health_issues": 1,
    "intelligence": 3,
    "shedding_level": 3,
    "social_needs": 4,
    "stranger_friendly": 4,
    "vocalisation": 3,
    "experimental": 0,
    "hairless": 0,
    "natural": 0,
    "rare": 0,
    "rex": 0,
    "suppressed_tail": 0,
    "short_legs": 0,
    "wikipedia_url": "https://en.wikipedia.org/wiki/Aegean_cat",
    "hypoallergenic": 0,
    "reference_image_id": "ozEvzdVM-"
  },
  {
    "weight": {
      "imperial": "7 - 16",
      "metric": "3 - 7"
    },
    "id": "abob",
    "name": "American Bobtail",
    "cfa_url": "http://cfa.org/Breeds/BreedsAB/AmericanBobtail.aspx",
    "vetstreet_url": "http://www.vetstreet.com/cats/american-bobtail",
    "vcahospitals_url": "https://vcahospitals.com/know-your-pet/cat-breeds/american-bobtail",
    "temperament": "Intelligent, Interactive, Lively, Playful, Sensitive",
    "origin": "United States",
    "country_codes": "US",
    "country_code": "US",
    "description": "American Bobtails are loving and incredibly intelligent cats possessing a distinctive wild appearance. They are extremely interactive cats that bond with their human family with great devotion.",
    "life_span": "11 - 15",
    "indoor": 0,
    "lap": 1,
    "alt_names": "",
    "adaptability": 5,
    "affection_level": 5,
    "child_friendly": 4,
    "dog_friendly": 5,
    "energy_level": 3,
    "grooming": 1,
    "health_issues": 1,
    "intelligence": 5,
    "shedding_level": 3,
    "social_needs": 3,
    "stranger_friendly": 3,
    "vocalisation": 3,
    "experimental": 0,
    "hairless": 0,
    "natural": 0,
    "rare": 0,
    "rex": 0,
    "suppressed_tail": 1,
    "short_legs": 0,
    "wikipedia_url": "https://en.wikipedia.org/wiki/American_Bobtail",
    "hypoallergenic": 0,
    "reference_image_id": "hBXicehMA"
  },
""".data(using: .utf8)!
    MockURLProtocol.error = nil
    MockURLProtocol.requestHandler = { request in
      let response = HTTPURLResponse(url: URL(string: "https://theiosdude.api.com/test")!,
                                     statusCode: 200,
                                     httpVersion: nil,
                                     headerFields: ["Content-Type": "application/json"])!
      return (response, jsonData)
    }

    Task {
      _ = await manager.searchByBreed("beng")
      assert(!manager.catBreeds.isEmpty)
    }
  }
}
