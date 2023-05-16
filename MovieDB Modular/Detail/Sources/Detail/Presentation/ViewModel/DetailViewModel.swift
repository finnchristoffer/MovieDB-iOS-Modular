//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 15/05/23.
//

import RxSwift
import RxCocoa
import Shared

class DetailViewModel {
  var detailMovie = BehaviorRelay<Movie?>(value: nil)
  var casterMovie = BehaviorRelay<[Cast]>(value: [])
  var isFavorite = BehaviorRelay<Bool>(value: false)
  
  private let disposeBag = DisposeBag()
  private let moviesDetailUseCase: GetMovieDetailUseCase
  private let casterMovieUseCase: GetMovieCasterUseCase
  private let insertMovieToFavoriteUseCase: InsertFavoriteMovieUseCase
  private let checkIsFavoriteUseCase: CheckIsFavoriteMovieUseCase
  private let deleteMovieFromFavoriteUseCase: DeleteFavoriteMovieUseCase
  
  init(
    moviesDetailUseCase: GetMovieDetailUseCase,
    casterMovieUseCase: GetMovieCasterUseCase,
    insertMovieToFavoriteUseCase: InsertFavoriteMovieUseCase,
    checkIsFavoriteUseCase: CheckIsFavoriteMovieUseCase,
    deleteMovieFromFavoriteUseCase: DeleteFavoriteMovieUseCase
  ) {
    self.moviesDetailUseCase = moviesDetailUseCase
    self.casterMovieUseCase = casterMovieUseCase
    self.insertMovieToFavoriteUseCase = insertMovieToFavoriteUseCase
    self.checkIsFavoriteUseCase = checkIsFavoriteUseCase
    self.deleteMovieFromFavoriteUseCase = deleteMovieFromFavoriteUseCase
  }
  
  func fetchDetailMovie(id: Int) {
    moviesDetailUseCase.execute(request: id)
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] movies in
        self?.detailMovie.accept(movies)
      }, onError: { error in
        print(error)
      }).disposed(by: disposeBag)
  }
  
  func fetchCasterMovie(id: Int) {
    casterMovieUseCase.execute(request: id)
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] movies in
        self?.casterMovie.accept(movies)
      }, onError: { error in
        print(error)
      }).disposed(by: disposeBag)
  }
  
  func insertToFavorite() -> Observable<Bool> {
    guard let movie = detailMovie.value else {
      return Observable.just(false)
    }
    return insertMovieToFavoriteUseCase.execute(request: movie)
  }
  
  func deleteFromFavorite() -> Observable<Bool> {
    guard let movieId = detailMovie.value?.id else {
      return Observable.just(false)
    }
    return deleteMovieFromFavoriteUseCase.execute(request: movieId)
      .map { _ in true }
      .catch { error in
        return Observable.just(false)
      }
      .do(onNext: { [weak self] isSuccess in
        if isSuccess {
          self?.isFavorite.accept(false)
        }
      })
  }
  
  func checkFavorite(movieId: Int?) -> Observable<Bool> {
    guard let movieId = movieId else {
      return Observable.just(false)
    }
    return checkIsFavoriteUseCase.execute(request: movieId)
      .observe(on: MainScheduler.instance)
      .catchAndReturn(false)
  }
}
