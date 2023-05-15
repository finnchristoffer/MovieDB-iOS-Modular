//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 14/05/23.
//

import RxSwift
import Core
import Shared

public struct GetNowPlayingMovieRepository: Repository {
  public typealias Request = Any
  public typealias Response = [Movie]
  
  private let remoteDataSource: GetNowPlayingMovieRemoteDataSource
  private let mapper: MovieResponsesToEntityMapper
  
  public init(
    remoteDataSource: GetNowPlayingMovieRemoteDataSource,
    mapper: MovieResponsesToEntityMapper
  ) {
    self.remoteDataSource = remoteDataSource
    self.mapper = mapper
  }
  
  public func execute(request: Request?) -> Observable<[Movie]> {
    return remoteDataSource.execute(request: request)
      .map { mapper.transform(from: $0 ) }
  }
}
