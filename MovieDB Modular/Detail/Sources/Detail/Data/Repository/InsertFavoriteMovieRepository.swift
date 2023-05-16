//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 15/05/23.
//

import RxSwift
import Core
import Shared

public struct InsertFavoriteMovieRepository: Repository {
  public typealias Request = Movie
  public typealias Response = Bool
  
  private let localDataSource: InsertFavoriteMovieDataSource
  private let mapper: MovieEntityToObjectMapper
  
  public init(
    localDataSource: InsertFavoriteMovieDataSource,
    mapper: MovieEntityToObjectMapper
  ) {
    self.localDataSource = localDataSource
    self.mapper = mapper
  }
  
  public func execute(request: Movie?) -> Observable<Bool> {
    return localDataSource.execute(request: mapper.transform(from: request!))
  }
}
