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

public struct GetMovieCasterRepository: Repository {
  public typealias Request = Int
  public typealias Response = [Cast]
  
  private let remoteDataSource: GetMovieCasterDataSource
  private let mapper: CastResponsesToDomainsMapper
  
  public init(
    remoteDataSource: GetMovieCasterDataSource,
    mapper: CastResponsesToDomainsMapper
  ) {
    self.remoteDataSource = remoteDataSource
    self.mapper = mapper
  }
  
  public func execute(request: Int?) -> Observable<[Cast]> {
    return remoteDataSource.execute(request: request)
      .map { mapper.transform(from: $0 ) }
  }
}
