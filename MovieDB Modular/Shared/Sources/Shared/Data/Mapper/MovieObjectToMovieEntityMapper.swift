//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 13/05/23.
//

import Core

public struct MovieObjectToMovieEntityMapper: Mapper {
  public typealias From = [MovieObject]
  public typealias To = [MovieEntity]
  
  public init() {}
  
  public func transform(from this: [MovieObject]) -> [MovieEntity] {
    return this.map { movieObject in
      let genres = movieObject.genres
        .lazy
        .map { GenreEntity(id: $0.id, name: $0.name) }
        .compactMap { $0 }
      return MovieEntity(
        id: movieObject.id, imageUrl: movieObject.imageUrl, title: movieObject.title, releaseDate: movieObject.releaseDate, genres: Array(genres)
      )
    }
  }
}
