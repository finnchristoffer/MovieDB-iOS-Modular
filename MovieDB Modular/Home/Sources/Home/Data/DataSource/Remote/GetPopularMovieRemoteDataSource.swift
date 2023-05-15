//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 14/05/23.
//

import Foundation
import Alamofire
import Combine
import Shared
import Core
import RxSwift

public struct GetPopularMovieRemoteDataSource: RemoteDataSource {
  public typealias Request = Any
  public typealias Response = [MovieModel]
  
  public func execute(request: Any?) -> Observable<[MovieModel]> {
    return Observable.create { observer in
      let request = AF.request(Endpoints.Get.popular.url)
        .validate()
        .responseDecodable(of: MovieResponse.self) { response in
          switch response.result {
          case .success(let movieResponse):
            observer.onNext(movieResponse.results ?? [])
            observer.onCompleted()
          case .failure(_):
            observer.onError(URLError.invalidResponse)
          }
        }
      return Disposables.create {
        request.cancel()
      }
    }
  }
}
