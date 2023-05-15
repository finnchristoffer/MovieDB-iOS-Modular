//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 14/05/23.
//

import Core
import RxSwift
import Shared

public struct GetPopularMovieUseCase: UseCase {
  public typealias Request = Any
  public typealias Response = [Movie]
  
  private let repository: GetPopularMovieRepository
  
  public init(repository: GetPopularMovieRepository) {
    self.repository = repository
  }
  
  public func execute(request: Request?) -> Observable<[Movie]> {
    return repository.execute(request: request)
  }
}
