//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 15/05/23.
//

import Core
import RealmSwift

public struct MovieEntityToObjectMapper: Mapper {
  public typealias From = Movie
  public typealias To = MovieObject
  
  public init() {}
  
  public func transform(from this: Movie) -> MovieObject {
    let genreList = List<GenreObject>()
    
    for genre in this.genres {
      let genreObject = GenreObject(id: genre.id, name: genre.name)
      genreList.append(genreObject)
    }
    
    return MovieObject(
      id: this.id ?? 0,
      imageUrl: this.backdropPath ?? "",
      title: this.title ?? "",
      releaseDate: this.releaseDate ?? "",
      genres: genreList
    )
  }
}
