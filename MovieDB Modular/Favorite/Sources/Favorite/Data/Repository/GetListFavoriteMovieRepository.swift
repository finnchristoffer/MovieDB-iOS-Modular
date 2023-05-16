//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 16/05/23.
//

import RxSwift
import RxCocoa
import Core
import Shared

public struct GetListFavoriteMovieRepository: Repository {
  public typealias Request = Any
  public typealias Response = [MovieObjectEntity]
  
  private let localDataSource: GetListFavoriteMovieDataSource
  private let mapper: MovieObjectToMovieEntityMapper
  
  public init(
    localDataSource: GetListFavoriteMovieDataSource,
    mapper: MovieObjectToMovieEntityMapper
  ) {
    self.localDataSource = localDataSource
    self.mapper = mapper
  }
  
  public func execute(request: Request?) -> Observable<[MovieObjectEntity]> {
    return localDataSource.execute(request: request)
      .map { mapper.transform(from: $0 ) }
  }
}
