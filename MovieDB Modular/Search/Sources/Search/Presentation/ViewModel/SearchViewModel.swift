//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 16/05/23.
//

import RxSwift
import RxCocoa
import Shared

class SearchViewModel {
  
  var searchMovies = BehaviorRelay<[Movie]>(value: [])
  
  private let disposeBag = DisposeBag()
  private let moviesSearchUseCase: SearchMovieUseCase
  
  init(movieSearchUseCase: SearchMovieUseCase) {
    self.moviesSearchUseCase = movieSearchUseCase
  }
  
  func fetchSearchMovies(input: String) {
    moviesSearchUseCase.execute(request: input)
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] movies in
        self?.searchMovies.accept(movies)
      }, onError: { error in
        print(error)
      }).disposed(by: disposeBag)
  }
  
  func clearMovieSearch() {
    searchMovies.accept([])
  }
}
