//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 15/05/23.
//

import Core
import Shared
import RxSwift
import RxCocoa
import RealmSwift

public struct CheckIsFavoriteDataSource: LocalDataSource {
  public typealias Request = Int
  public typealias Response = Bool
  
  public let realm: Realm
  public init(realm: Realm) {
    self.realm = realm
  }
  
  public func execute(request: Int?) -> Observable<Bool> {
    return Observable.create { observer in
      do {
        let movieObject = self.realm.objects(MovieObject.self)
        let results = movieObject.filter {
          $0.id == request!
        }
        let data = Array(results)
        if data.isEmpty {
          observer.onNext(false)
        } else {
          observer.onNext(true)
        }
        observer.onCompleted()
      }
      return Disposables.create()
    }
  }
}
