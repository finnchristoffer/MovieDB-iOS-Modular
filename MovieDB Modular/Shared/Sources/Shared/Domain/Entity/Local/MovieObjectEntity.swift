//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 13/05/23.
//

import Foundation

public struct MovieObjectEntity: Equatable, Identifiable {
  public let id: Int
  public let imageUrl: String
  public let title: String
  public let releaseDate: String
  public let genres: [GenreObjectEntity?]
  
  public init(id: Int, imageUrl: String, title: String, releaseDate: String, genres: [GenreObjectEntity?]) {
    self.id = id
    self.imageUrl = imageUrl
    self.title = title
    self.releaseDate = releaseDate
    self.genres = genres
  }
}
