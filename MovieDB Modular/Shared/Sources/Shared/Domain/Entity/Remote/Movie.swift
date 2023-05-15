//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 13/05/23.
//

import Foundation

public struct Movie: Equatable, Identifiable {
  public let adult: Bool?
  public let backdropPath: String?
  public let genreIDS: [Int]?
  public let id: Int?
  public let originalLanguage, originalTitle, overview: String?
  public let popularity: Double?
  public let posterPath, releaseDate, title: String?
  public let video: Bool?
  public let voteAverage: Double?
  public let voteCount: Int?
  public let runtime: Int?
  public let genres: [Genre]
  
  public init(adult: Bool?, backdropPath: String?, genreIDS: [Int]?, id: Int?, originalLanguage: String?, originalTitle: String?, overview: String?, popularity: Double?, posterPath: String?, releaseDate: String?, title: String?, video: Bool?, voteAverage: Double?, voteCount: Int?, runtime: Int?, genres: [Genre]) {
    self.adult = adult
    self.backdropPath = backdropPath
    self.genreIDS = genreIDS
    self.id = id
    self.originalLanguage = originalLanguage
    self.originalTitle = originalTitle
    self.overview = overview
    self.popularity = popularity
    self.posterPath = posterPath
    self.releaseDate = releaseDate
    self.title = title
    self.video = video
    self.voteAverage = voteAverage
    self.voteCount = voteCount
    self.runtime = runtime
    self.genres = genres
  }
}
