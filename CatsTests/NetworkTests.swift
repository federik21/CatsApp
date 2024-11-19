//
//  TestNetwork.swift
//  CatsTests
//
//  Created by federico piccirilli on 19/11/2024.
//

import Foundation
import XCTest

class NetworkTests: XCTestCase {

  var client: CatNetworkService!

  override func setUp() {
    client = CatNetworkService(urlSession: {
      let configuration: URLSessionConfiguration = .ephemeral
      configuration.protocolClasses = [MockURLProtocol.self]
      return URLSession(configuration: configuration)
    }())
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testGetImages () {
    let jsonData = """
[{"id":"38i","url":"https://cdn2.thecatapi.com/images/38i.jpg","width":1024,"height":680},{"id":"3p4","url":"https://cdn2.thecatapi.com/images/3p4.gif","width":294,"height":221},{"id":"a13","url":"https://cdn2.thecatapi.com/images/a13.jpg","width":500,"height":332},{"id":"bgc","url":"https://cdn2.thecatapi.com/images/bgc.png","width":500,"height":373},{"id":"cti","url":"https://cdn2.thecatapi.com/images/cti.jpg","width":640,"height":480},{"id":"e1f","url":"https://cdn2.thecatapi.com/images/e1f.jpg","width":834,"height":1200},{"id":"e9s","url":"https://cdn2.thecatapi.com/images/e9s.jpg","width":400,"height":500},{"id":"MTg2NjU5NA","url":"https://cdn2.thecatapi.com/images/MTg2NjU5NA.jpg","width":560,"height":644},{"id":"MjA0OTk3Mg","url":"https://cdn2.thecatapi.com/images/MjA0OTk3Mg.jpg","width":2592,"height":1944},{"id":"MjA3NDUzNg","url":"https://cdn2.thecatapi.com/images/MjA3NDUzNg.jpg","width":720,"height":540}]
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
      let cats = try await client.fetchCatImages(by: nil)
      assert(!cats.isEmpty)
    }
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
      let cats = try await client.getCats(by: "beng")
      assert(!cats.isEmpty)
    }
  }

  func testVote() {
    let jsonData = """
    {
    "message": "SUCCESS",
    "id": 1120951,
    "image_id": "asf2",
    "sub_id": "my-user-1234",
    "value": 1,
    "country_code": "AU"
    }
    """.data(using: .utf8)!
    MockURLProtocol.error = nil
    MockURLProtocol.requestHandler = { request in
      let response = HTTPURLResponse(url: URL(string: "https://theiosdude.api.com/test")!,
                                     statusCode: 201,
                                     httpVersion: nil,
                                     headerFields: ["Content-Type": "application/json"])!
      return (response, jsonData)
    }
    Task {
      let response = try await client.addVote(vote: -1, id: "beng")
      assert(response.message == "SUCCESS")
    }
  }

  func testInvalidResponse() {
    let jsonData = """
    {
    "message": "SUCCESS",
    "id": 1120951,
    "image_id": "asf2",
    "sub_id": "my-user-1234",
    "value": 1,
    "country_code": "AU"
    }
    """.data(using: .utf8)!
    MockURLProtocol.error = nil
    MockURLProtocol.requestHandler = { request in
      let response = HTTPURLResponse(url: URL(string: "https://theiosdude.api.com/test")!,
                                     statusCode: 404,
                                     httpVersion: nil,
                                     headerFields: ["Content-Type": "application/json"])!
      return (response, jsonData)
    }
    Task {
      do {
        _ = try await client.addVote(vote: -1, id: "beng")
        assert(false)
      } catch let error as NetworkError {
        assert(type(of: error) == type(of: NetworkError.requestFailed(statusCode: 404)))
      }
    }
  }
}
