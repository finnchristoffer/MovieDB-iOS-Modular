//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 15/05/23.
//

import RxSwift
import RxCocoa
import Shared
import Core

public struct DeleteFavoriteMovieRepository: Repository {
  public typealias Request = Int
  public typealias Response = Bool
  
  private let localDataSource: DeleteFavoriteMovieDataSource
  
  public init(
    localDataSource: DeleteFavoriteMovieDataSource
  ) {
    self.localDataSource = localDataSource
  }
  
  public func execute(request: Int?) -> Observable<Bool> {
    return localDataSource.execute(request: request)
  }
}
