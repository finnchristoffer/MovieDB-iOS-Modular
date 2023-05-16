//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 16/05/23.
//

import Swinject
import Shared

public class SearchModule {
  public init() {}
  
  public let container: Container = {
    let container = Container()
    
    // MARK: - DataSource
    container.register(SearchMovieRemoteDataSource.self) { _ in
      SearchMovieRemoteDataSource()
    }
    
    // MARK: - Repository
    container.register(SearchMovieRepository.self) { resolver in
      SearchMovieRepository(
        remoteDataSource: resolver.resolve(SearchMovieRemoteDataSource.self)!,
        mapper: SharedModule().container.resolve(MovieResponsesToEntityMapper.self)!
      )
    }
    
    // MARK: - UseCase
    container.register(SearchMovieUseCase.self) { resolver in
      SearchMovieUseCase(repository: resolver.resolve(SearchMovieRepository.self)!)
    }
    
    // MARK: - ViewModel
    container.register(SearchViewModel.self) { resolver in
      SearchViewModel(
        movieSearchUseCase: resolver.resolve(SearchMovieUseCase.self)!
      )
    }
    
    // MARK: ViewController
    container.register(SearchViewController.self) { resolver in
      let viewModel = resolver.resolve(SearchViewModel.self)!
      return SearchViewController(viewModel: viewModel)
    }
    
    return container
  }()
}

