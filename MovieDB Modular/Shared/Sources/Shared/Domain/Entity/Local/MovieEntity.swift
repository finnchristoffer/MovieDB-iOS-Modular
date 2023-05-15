//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 13/05/23.
//

import Foundation

public struct MovieEntity: Equatable, Identifiable {
  public let id: Int
  public let imageUrl: String
  public let title: String
  public let releaseDate: String
  public let genres: [GenreEntity?]
  
  public init(id: Int, imageUrl: String, title: String, releaseDate: String, genres: [GenreEntity?]) {
    self.id = id
    self.imageUrl = imageUrl
    self.title = title
    self.releaseDate = releaseDate
    self.genres = genres
  }
}
