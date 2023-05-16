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
import RealmSwift

public struct GetListFavoriteMovieDataSource: LocalDataSource {
  public typealias Request = Any
  public typealias Response = [MovieObject]
  
  private let realm: Realm
  public init(realm: Realm) {
    self.realm = realm
  }
  
  public func execute(request: Request?) -> Observable<[MovieObject]> {
    return Observable.create { observer -> Disposable in
      let movieList: Results<MovieObject> = {
        self.realm.objects(MovieObject.self)
          .sorted(byKeyPath: "title", ascending: true)
      }()
      observer.onNext(movieList.toArray(ofType: MovieObject.self))
      observer.onCompleted()
      
      return Disposables.create()
    }
  }
}
