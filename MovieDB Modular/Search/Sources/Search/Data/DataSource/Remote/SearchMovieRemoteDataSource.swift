//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 16/05/23.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa
import Shared
import Core

public struct SearchMovieRemoteDataSource: RemoteDataSource {
  public typealias Request = String
  public typealias Response = [MovieModel]
  
  public func execute(request: String?) -> Observable<[MovieModel]> {
    return Observable.create { observer in
      let request = AF.request(Endpoints.Get.search(query: request!).url)
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
