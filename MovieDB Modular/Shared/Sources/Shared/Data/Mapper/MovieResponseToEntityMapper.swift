//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 13/05/23.
//

import Core

public struct MovieResponseToEntityMapper: Mapper {
  public typealias From = MovieModel
  public typealias To = Movie
  
  public init() {}
  
  public func transform(from this: MovieModel) -> Movie {
    let genres = this.genres?.map { genreModel in
      return Genre(id: genreModel.id, name: genreModel.name)
    }
    return Movie(
      adult: this.adult,
      backdropPath: this.backdropPath,
      genreIDS: this.genreIDS,
      id: this.id,
      originalLanguage: this.originalLanguage,
      originalTitle: this.originalTitle,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      releaseDate: this.releaseDate,
      title: this.title,
      video: this.video,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
      runtime: this.runtime,
      genres: genres ?? []
    )
  }
}
