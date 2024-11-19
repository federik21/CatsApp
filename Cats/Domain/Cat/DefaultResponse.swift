//
//  Message.swift
//  Cats
//
//  Created by federico piccirilli on 19/11/2024.
//

import Foundation

struct DefaultResponse: Codable {
  let message: String
  let id: Int
  let imageId: String
  let subId: String
  let value: Int
  let countryCode: String
}
