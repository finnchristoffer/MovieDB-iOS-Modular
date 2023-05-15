//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 14/05/23.
//

import Swinject
import Shared

public class HomeModule {
  public init() {}
  
  public let container: Container = {
    let container = Container()
    
    // MARK: - DataSource
    container.register(GetPopularMovieRemoteDataSource.self) { _ in
      GetPopularMovieRemoteDataSource()
    }
    
    container.register(GetUpcomingMovieRemoteDataSource.self) { _ in
      GetUpcomingMovieRemoteDataSource()
    }
    
    container.register(GetNowPlayingMovieRemoteDataSource.self) { _ in
      GetNowPlayingMovieRemoteDataSource()
    }
    
    // MARK: - Repository
    container.register(GetPopularMovieRepository.self) { resolver in
      GetPopularMovieRepository(
        remoteDataSource: resolver.resolve(GetPopularMovieRemoteDataSource.self)!,
        mapper: SharedModule().container.resolve(MovieResponsesToEntityMapper.self)!
      )
    }
    
    container.register(GetUpcomingMovieRepository.self) { resolver in
      GetUpcomingMovieRepository(
        remoteDataSource: resolver.resolve(GetUpcomingMovieRemoteDataSource.self)!,
        mapper: SharedModule().container.resolve(MovieResponsesToEntityMapper.self)!
      )
    }
    
    container.register(GetNowPlayingMovieRepository.self) { resolver in
      GetNowPlayingMovieRepository(
        remoteDataSource: resolver.resolve(GetNowPlayingMovieRemoteDataSource.self)!,
        mapper: SharedModule().container.resolve(MovieResponsesToEntityMapper.self)!
      )
    }
    
    // MARK: - UseCase
    container.register(GetPopularMovieUseCase.self) { resolver in
      GetPopularMovieUseCase(repository: resolver.resolve(GetPopularMovieRepository.self)!)
    }
    
    container.register(GetUpComingMovieUseCase.self) { resolver in
      GetUpComingMovieUseCase(repository: resolver.resolve(GetUpcomingMovieRepository.self)!)
    }
    
    container.register(GetNowPlayingMovieUseCase.self) { resolver in
      GetNowPlayingMovieUseCase(repository: resolver.resolve(GetNowPlayingMovieRepository.self)!)
    }
    
    // MARK: - ViewModel
    container.register(HomeViewModel.self) { resolver in
      HomeViewModel(
        movieUpComingUseCase: resolver.resolve(GetUpComingMovieUseCase.self)!,
        moviePopularUseCase: resolver.resolve(GetPopularMovieUseCase.self)!,
        movieNowPlayingUseCase: resolver.resolve(GetNowPlayingMovieUseCase.self)!
      )
    }
    
    // MARK: - ViewController
    container.register(HomeViewController.self) { resolver in
      let viewModel = resolver.resolve(HomeViewModel.self)!
      return HomeViewController(viewModel: viewModel)
    }
    
    return container
  }()
}
