//
//  NetworkError.swift
//  Cats
//
//  Created by federico piccirilli on 19/11/2024.
//

import Foundation

enum NetworkError: Error {
  case invalidURL
  case invalidBody
  case requestFailed(statusCode: Int)
  case invalidResponse
  case dataConversionFailure
}
