//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 16/05/23.
//

import Core
import Shared
import RxSwift
import RxCocoa

public struct SearchMovieUseCase: UseCase {
  public typealias Request = String
  public typealias Response = [Movie]
  
  private let repository: SearchMovieRepository
  
  public init(repository: SearchMovieRepository) {
    self.repository = repository
  }
  
  public func execute(request: String?) -> Observable<[Movie]> {
    return repository.execute(request: request)
  }
}
