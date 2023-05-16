//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 16/05/23.
//

import Core
import RxSwift
import RxCocoa
import Shared

public struct GetListFavoriteMovieUseCase: UseCase {
  public typealias Request = Any
  public typealias Response = [MovieObjectEntity]
  
  private let repository: GetListFavoriteMovieRepository
  
  public init(repository: GetListFavoriteMovieRepository) {
    self.repository = repository
  }
  
  public func execute(request: Request?) -> Observable<[MovieObjectEntity]> {
    return repository.execute(request: request)
  }
}
