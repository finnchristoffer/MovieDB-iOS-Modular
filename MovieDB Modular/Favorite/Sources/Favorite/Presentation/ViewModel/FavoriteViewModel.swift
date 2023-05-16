//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 16/05/23.
//

import RxSwift
import RxCocoa
import Shared

class FavoriteViewModel {
  
  var favoriteMovies = BehaviorRelay<[MovieObjectEntity]>(value: [])
  var favoriteMovieSearch = BehaviorRelay<[MovieObjectEntity]>(value: [])
  
  private let disposeBag = DisposeBag()
  private let moviesFavoriteUseCase: GetListFavoriteMovieUseCase
  
  init(movieFavoriteUseCase: GetListFavoriteMovieUseCase) {
    self.moviesFavoriteUseCase = movieFavoriteUseCase
  }
  
  func fetchSearchMovies() {
    moviesFavoriteUseCase.execute(request: nil)
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] favorite in
        self?.favoriteMovies.accept(favorite)
      }, onError: { error in
        print(error)
      }, onCompleted: {
        print(self.favoriteMovies.value)
      }).disposed(by: disposeBag)
  }
  
  func favoriteMovieSearched(input: String) {
    let filteredMovies = favoriteMovies.value.compactMap { $0.title.localizedStandardContains(input) == true ? $0 : nil }
      favoriteMovieSearch.accept(filteredMovies)
  }
  
  func clearFavoriteMovieSearch() {
    favoriteMovieSearch.accept([])
  }
}


