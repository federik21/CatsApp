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
}
