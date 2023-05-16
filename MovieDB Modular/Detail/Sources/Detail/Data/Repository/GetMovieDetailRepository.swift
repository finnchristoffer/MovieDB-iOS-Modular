//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 15/05/23.
//

import RxSwift
import RxCocoa
import Core
import Shared

public struct GetMovieDetailRepository: Repository {
  public typealias Request = Int
  public typealias Response = Movie
  
  private let remoteDataSource: GetMovieDetailDataSource
  private let mapper: MovieResponseToEntityMapper
  
  public init(
    remoteDataSource: GetMovieDetailDataSource,
    mapper: MovieResponseToEntityMapper
  ) {
    self.remoteDataSource = remoteDataSource
    self.mapper = mapper
  }
  
  public func execute(request: Int?) -> Observable<Movie> {
    return remoteDataSource.execute(request: request)
      .map { mapper.transform(from: $0 ) }
  }
}
