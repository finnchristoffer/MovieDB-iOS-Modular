//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 15/05/23.
//

import Core
import RxSwift
import Shared

public struct GetNowPlayingMovieUseCase: UseCase {
  public typealias Request = Any
  public typealias Response = [Movie]
  
  private let repository: GetNowPlayingMovieRepository
  
  public init(repository: GetNowPlayingMovieRepository) {
    self.repository = repository
  }
  
  public func execute(request: Request?) -> Observable<[Movie]> {
    return repository.execute(request: request)
  }
}
