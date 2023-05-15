//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 13/05/23.
//

import Core

public struct MovieResponsesToEntityMapper: Mapper {
  public typealias From = [MovieModel]
  public typealias To = [Movie]
  
  public init() {}
  
  public func transform(from this: [MovieModel]) -> [Movie] {
    return this.map { result in
      let genres = result.genres?.map { genreModel in
        return Genre(id: genreModel.id, name: genreModel.name)
      }
      return Movie(
        adult: result.adult,
        backdropPath: result.backdropPath,
        genreIDS: result.genreIDS,
        id: result.id,
        originalLanguage: result.originalLanguage,
        originalTitle: result.originalTitle,
        overview: result.overview,
        popularity: result.popularity,
        posterPath: result.posterPath,
        releaseDate: result.releaseDate,
        title: result.title,
        video: result.video,
        voteAverage: result.voteAverage,
        voteCount: result.voteCount,
        runtime: result.runtime,
        genres: genres ?? []
      )
    }
  }
}
