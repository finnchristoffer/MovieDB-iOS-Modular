//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 15/05/23.
//

import Core
import RxSwift
import Shared

public struct GetUpComingMovieUseCase: UseCase {
  public typealias Request = Any
  public typealias Response = [Movie]
  
  private let repository: GetUpcomingMovieRepository
  
  public init(repository: GetUpcomingMovieRepository) {
    self.repository = repository
  }
  
  public func execute(request: Request?) -> Observable<[Movie]> {
    return repository.execute(request: request)
  }
}
