//
//  Router.swift
//  Cats
//
//  Created by federico piccirilli on 19/11/2024.
//


import Foundation

enum Router: URLRequestConvertible {

  case getCats

  var endpoint: String {
    switch self {
    case .getCats:
      return "v1/images/"
    }
  }

  var method: String {
    switch self {
    default: return "GET"
    }
  }

  func makeURLRequest(_ baseURL: String) throws -> URLRequest {
    guard let url = URL(string: baseURL + endpoint) else {
      throw NetworkError.invalidURL
    }

    var request = URLRequest(url: url)
    request.httpMethod = method

    return request
  }
}
