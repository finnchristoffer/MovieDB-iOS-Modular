//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 13/05/23.
//

import RealmSwift

public class MovieObject: Object {
  @Persisted public var id: Int = 0
  @Persisted public var imageUrl: String = ""
  @Persisted public var title: String = ""
  @Persisted public var releaseDate: String = ""
  @Persisted public var genres: List<GenreObject> = List<GenreObject>()
  
  public convenience init(
    id: Int,
    imageUrl: String,
    title: String,
    releaseDate: String,
    genres: List<GenreObject>
  ) {
    self.init()
    self.id = id
    self.imageUrl = imageUrl
    self.title = title
    self.releaseDate = releaseDate
    self.genres = genres
  }
}
