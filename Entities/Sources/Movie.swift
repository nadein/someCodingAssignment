//
//  Movie.swift
//  Entities
//
//  Created by Frederik Christensen on 19/01/2021.
//

import Foundation

public struct Movie: Codable {
  
    private enum CodingKeys: String, CodingKey {
      case id
      case title
      case posterPath = "poster_path"
    }
  
    public let id: Int
    public let title: String
    public let posterPath: String?
}
