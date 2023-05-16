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

public struct DeleteFavoriteMovieDataSource: LocalDataSource {
  public typealias Request = Int
  public typealias Response = Bool
  
  private let realm: Realm
  public init(realm: Realm) {
    self.realm = realm
  }
  
  public func execute(request: Int?) -> Observable<Bool> {
    return Observable.create { observer in
      do {
        try self.realm.write {
          let movieObjects = self.realm.objects(MovieObject.self)
          let results = movieObjects.filter {
            $0.id == request!
          }
          self.realm.delete(results)
          observer.onNext(true)
        }
      } catch {
        observer.onError(DatabaseError.requestFailed)
      }
      observer.onCompleted()
      return Disposables.create()
    }
  }
}
