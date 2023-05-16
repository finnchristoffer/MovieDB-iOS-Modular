//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 16/05/23.
//

import Core
import Shared
import RxSwift
import RxCocoa

public struct SearchMovieRepository: Repository {
  public typealias Request = String
  public typealias Response = [Movie]
  
  private let remoteDataSource: SearchMovieRemoteDataSource
  private let mapper: MovieResponsesToEntityMapper
  
  public init(
    remoteDataSource: SearchMovieRemoteDataSource,
    mapper: MovieResponsesToEntityMapper
  ) {
    self.remoteDataSource = remoteDataSource
    self.mapper = mapper
  }
  
  public func execute(request: String?) -> Observable<[Movie]> {
    return remoteDataSource.execute(request: request)
      .map { mapper.transform(from: $0 ) }
  }
}
