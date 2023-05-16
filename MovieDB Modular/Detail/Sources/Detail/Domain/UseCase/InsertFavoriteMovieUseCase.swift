//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 15/05/23.
//

import Core
import RxCocoa
import RxSwift
import Shared

public struct InsertFavoriteMovieUseCase: UseCase {
  public typealias Request = Movie
  public typealias Response = Bool
  
  private let repository: InsertFavoriteMovieRepository
  
  public init(repository: InsertFavoriteMovieRepository) {
    self.repository = repository
  }
  
  public func execute(request: Movie?) -> Observable<Bool> {
    return repository.execute(request: request)
  }
}
