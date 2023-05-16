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

public struct GetMovieCasterUseCase: UseCase {
  public typealias Request = Int
  public typealias Response = [Cast]
  
  private let repository: GetMovieCasterRepository
  
  public init(repository: GetMovieCasterRepository) {
    self.repository = repository
  }
  
  public func execute(request: Int?) -> Observable<[Cast]> {
    return repository.execute(request: request)
  }
}
