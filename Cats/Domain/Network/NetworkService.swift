//
//  NetworkService.swift
//  Cats
//
//  Created by federico piccirilli on 19/11/2024.
//


import Foundation

enum APIConfig {
  static let prodBaseUrl = "https://api.thecatapi.com/"
  static let apikey = "live_zRkJnXW86zfj2v0UqW52apqtFEhRRfdhg9UmORWrn2WxPcea9oUidO4Jrc4WUK3J"
}

class BaseNetworkService<Router: URLRequestConvertible> {

  var urlSession: URLSession
  var baseURL: String

  init(urlSession: URLSession = URLSession.shared,
       baseUrl: String = APIConfig.prodBaseUrl) {
    self.urlSession = urlSession
    self.baseURL = baseUrl
  }

  private func handleResponse(data: Data, response: URLResponse) throws {
    guard let httpResponse = response as? HTTPURLResponse else {
      throw NetworkError.invalidResponse
    }

    guard (200...299).contains(httpResponse.statusCode) else {
      throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
    }
  }

  /// Performs an asynchronous network request and decodes the response data
  /// into the specified type.
  ///
  /// - Parameters:
  ///   - router: An object conforming to the `URLRequestConvertible` protocol.
  ///   - returnType: The type into which the response data should be decoded.
  ///
  /// - Throws:
  ///   - `NetworkError.dataConversionFailure` if data cannot be decoded into the specified type.
  ///
  /// - Returns:
  ///   The decoded data of the specified type.
  func request<T: Decodable>(_ returnType: T.Type, router: Router) async throws -> T {
    var request = try router.makeURLRequest(baseURL)
    request.setValue(APIConfig.apikey, forHTTPHeaderField: "x-api-key")

    let (data, response) = try await urlSession.data(for: request)

    try handleResponse(data: data, response: response)

    let decoder = JSONDecoder()
    do {
      let decodedData = try decoder.decode(returnType, from: data)
      return decodedData
    } catch {
      throw NetworkError.dataConversionFailure
    }
  }
}

protocol URLRequestConvertible {
  func makeURLRequest(_ baseURL: String) throws -> URLRequest
}
