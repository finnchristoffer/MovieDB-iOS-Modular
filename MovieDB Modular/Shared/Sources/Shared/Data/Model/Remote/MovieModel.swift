//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 13/05/23.
//

import Foundation

// MARK: - MovieResponse
public struct MovieResponse: Codable {
  let dates: Dates?
  let page: Int?
  public let results: [MovieModel]?
  let totalPages, totalResults: Int?
  
  enum CodingKeys: String, CodingKey {
    case dates, page, results
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}

// MARK: - Dates
public struct Dates: Codable {
  let maximum, minimum: String?
}

// MARK: - Movie
public struct MovieModel: Codable {
  let adult: Bool?
  let backdropPath: String?
  let genreIDS: [Int]?
  let id: Int?
  let originalLanguage, originalTitle, overview: String?
  let popularity: Double?
  let posterPath, releaseDate, title: String?
  let video: Bool?
  let voteAverage: Double?
  let voteCount: Int?
  let runtime: Int?
  let genres: [GenreModel]?
  
  enum CodingKeys: String, CodingKey {
    case adult
    case backdropPath = "backdrop_path"
    case genreIDS = "genre_ids"
    case id
    case originalLanguage = "original_language"
    case originalTitle = "original_title"
    case overview, popularity
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case title, video
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
    case runtime = "runtime"
    case genres
  }
}

public struct GenreModel: Codable {
  let id: Int
  let name: String
}

