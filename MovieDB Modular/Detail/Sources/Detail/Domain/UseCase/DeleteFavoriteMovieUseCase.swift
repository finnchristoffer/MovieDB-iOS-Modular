//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 15/05/23.
//

import Core
import RxSwift
import RxCocoa
import Shared

public struct DeleteFavoriteMovieUseCase: UseCase {
  public typealias Request = Int
  public typealias Response = Bool
  
  private let repository: DeleteFavoriteMovieRepository
  
  public init(repository: DeleteFavoriteMovieRepository) {
    self.repository = repository
  }
  
  public func execute(request: Int?) -> Observable<Bool> {
    return repository.execute(request: request)
  }
}
