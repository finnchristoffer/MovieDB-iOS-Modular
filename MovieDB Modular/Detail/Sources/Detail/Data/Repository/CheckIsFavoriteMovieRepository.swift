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

public struct CheckIsFavoriteMovieRepository: Repository {
  public typealias Request = Int
  public typealias Response = Bool
  
  private let localDataSource: CheckIsFavoriteDataSource
  
  public init(
    localDataSource: CheckIsFavoriteDataSource
  ) {
    self.localDataSource = localDataSource
  }
  
  public func execute(request: Int?) -> Observable<Bool> {
    return localDataSource.execute(request: request)
  }
}
