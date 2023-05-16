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

public struct InsertFavoriteMovieDataSource: LocalDataSource {
  public typealias Request = MovieObject
  public typealias Response = Bool
  
  private let realm: Realm
  public init(realm: Realm) {
    self.realm = realm
  }
  
  public func execute(request: MovieObject?) -> Observable<Bool> {
    return Observable.create { observer in
      do {
        try self.realm.write {
          if let genres = request?.genres {
            let genreList = List<GenreObject>()
            for genre in genres {
              let genreObject = GenreObject(id: genre.id, name: genre.name)
              genreList.append(genreObject)
            }
            let movieObject = MovieObject(
              id: request!.id,
              imageUrl: request!.imageUrl,
              title: request!.title,
              releaseDate: request!.releaseDate,
              genres: genreList
            )
            self.realm.add(movieObject)
          }
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

