//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 14/05/23.
//

import RxSwift
import RxCocoa
import Shared

class HomeViewModel {
  var popularMovie = BehaviorRelay<[Movie]>(value: [])
  var upcomingMovies = BehaviorRelay<[Movie]>(value: [])
  var nowPlayingMovies = BehaviorRelay<[Movie]>(value: [])
  
  private let disposeBag = DisposeBag()
  private let moviesPopularUseCase: GetPopularMovieUseCase
  private let moviesUpcomingUseCase: GetUpComingMovieUseCase
  private let moviesNowPlayingUseCase: GetNowPlayingMovieUseCase

  init(
    movieUpComingUseCase: GetUpComingMovieUseCase,
    moviePopularUseCase: GetPopularMovieUseCase,
    movieNowPlayingUseCase: GetNowPlayingMovieUseCase
  ) {
    self.moviesUpcomingUseCase = movieUpComingUseCase
    self.moviesPopularUseCase = moviePopularUseCase
    self.moviesNowPlayingUseCase = movieNowPlayingUseCase
  }

  func fetchUpcomingMovies() {
    moviesUpcomingUseCase.execute(request: nil)
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] movies in
        self?.upcomingMovies.accept(movies)
      }, onError: { error in
        print(error)
      }).disposed(by: disposeBag)
  }

  func fetchPopularMovies() {
    moviesPopularUseCase.execute(request: nil)
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] movies in
        self?.popularMovie.accept(movies)
      }, onError: { error in
        print(error)
      }).disposed(by: disposeBag)
  }

  func fetchNowPlayingMovies() {
    moviesNowPlayingUseCase.execute(request: nil)
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] movies in
        self?.nowPlayingMovies.accept(movies)
      }, onError: { error in
        print(error)
      }).disposed(by: disposeBag)
  }
}
