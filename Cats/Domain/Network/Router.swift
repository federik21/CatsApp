//
//  Router.swift
//  Cats
//
//  Created by federico piccirilli on 19/11/2024.
//


import Foundation

enum Router: URLRequestConvertible {

  case getCats
  case getBreeds
  case getCat(breed: String)
  case addVote(value: Int, id: String)

  var endpoint: String {
    switch self {
    case .getCats:
      return "v1/images/"
    case .getBreeds:
      return "v1/breeds/"
    case .getCat(breed: let breed):
      return "v1/breeds/search?q=\(breed)"
    case .addVote:
      return "v1/votes"
    }
  }

  var method: RequestMethod {
    switch self {
    case .addVote:
      return .post
    default:
      return .get
    }
  }

  var postData: [String: Any]? {
    switch self {
    case .addVote(let value, let id):
      return [
        "value" : value,
        "image_id" : id]
    default:
      return nil
    }
  }


  func makeURLRequest(_ baseURL: String) throws -> URLRequest {
    guard let url = URL(string: baseURL + endpoint) else {
      throw NetworkError.invalidURL
    }

    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue

    switch method {
    case .post:
      if let postData = postData {
      do {
          request.httpBody = try JSONSerialization.data(withJSONObject: postData, options: [])
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
          throw NetworkError.invalidBody
        }
      }
    default:
      break
    }
    return request
  }
}

enum RequestMethod: String {
  case delete = "DELETE"
  case get = "GET"
  case patch = "PATCH"
  case post = "POST"
  case put = "PUT"
}
