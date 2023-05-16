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

public struct GetMovieCasterDataSource: RemoteDataSource {
  public typealias Request = Int
  public typealias Response = [CastModel]
  
  public func execute(request: Int?) -> Observable<[CastModel]> {
    return Observable.create { observer in
      let request = AF.request(Endpoints.Get.movieCast(id: request!).url)
        .validate()
        .responseDecodable(of: CastResponse.self) { response in
          switch response.result {
          case .success(let castResponse):
            observer.onNext(castResponse.cast ?? [])
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
