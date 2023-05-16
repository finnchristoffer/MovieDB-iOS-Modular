//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 15/05/23.
//

import Alamofire
import RxSwift
import RxCocoa
import Core
import Shared

public struct GetMovieDetailDataSource: RemoteDataSource {
  public typealias Request = Int
  public typealias Response = MovieModel
  
  public func execute(request: Int?) -> Observable<MovieModel> {
    return Observable.create { observer in
      let request = AF.request(Endpoints.Get.movie(id: request!).url)
        .validate()
        .responseDecodable(of: MovieModel.self) { response in
          switch response.result {
          case .success(let movie):
            observer.onNext(movie)
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
