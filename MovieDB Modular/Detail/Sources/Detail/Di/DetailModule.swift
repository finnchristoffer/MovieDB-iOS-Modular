//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 15/05/23.
//

import Shared
import Swinject
import RealmSwift

public class DetailModule {
  public init() {}
  
  public let container: Container = {
    let container = Container()
    
    // MARK: - DataSource
    container.register(GetMovieDetailDataSource.self) { _ in
      GetMovieDetailDataSource()
    }
    
    container.register(GetMovieCasterDataSource.self) { _ in
      GetMovieCasterDataSource()
    }
    
    container.register(InsertFavoriteMovieDataSource.self) { _ in
      InsertFavoriteMovieDataSource(realm: try! Realm())
    }
    
    container.register(DeleteFavoriteMovieDataSource.self) { _ in
      DeleteFavoriteMovieDataSource(realm: try! Realm())
    }
    
    container.register(CheckIsFavoriteDataSource.self) { _ in
      CheckIsFavoriteDataSource(realm: try! Realm())
    }
    
    // MARK: - Repository
    container.register(GetMovieDetailRepository.self) { resolver in
      GetMovieDetailRepository(
        remoteDataSource: resolver.resolve(GetMovieDetailDataSource.self)!,
        mapper: SharedModule().container.resolve(MovieResponseToEntityMapper.self)!
      )
    }
    
    container.register(GetMovieCasterRepository.self) { resolver in
      GetMovieCasterRepository(
        remoteDataSource: resolver.resolve(GetMovieCasterDataSource.self)!,
        mapper: SharedModule().container.resolve(CastResponsesToDomainsMapper.self)!)
    }
    
    container.register(InsertFavoriteMovieRepository.self) { resolver in
      InsertFavoriteMovieRepository(
        localDataSource: resolver.resolve(InsertFavoriteMovieDataSource.self)!,
        mapper: SharedModule().container.resolve(MovieEntityToObjectMapper.self)!
      )
    }
    
    container.register(DeleteFavoriteMovieRepository.self) { resolver in
      DeleteFavoriteMovieRepository(
        localDataSource: resolver.resolve(DeleteFavoriteMovieDataSource.self)!
      )
    }
    
    container.register(CheckIsFavoriteMovieRepository.self) { resolver in
      CheckIsFavoriteMovieRepository(localDataSource: resolver.resolve(CheckIsFavoriteDataSource.self)!
      )
    }
    
    // MARK: - UseCase
    container.register(GetMovieDetailUseCase.self) { resolver in
      GetMovieDetailUseCase(repository: resolver.resolve(GetMovieDetailRepository.self)!
      )
    }
    
    container.register(GetMovieCasterUseCase.self) { resolver in
      GetMovieCasterUseCase(repository: resolver.resolve(GetMovieCasterRepository.self)!
      )
    }
    
    container.register(InsertFavoriteMovieUseCase.self) { resolver in
      InsertFavoriteMovieUseCase(repository: resolver.resolve(InsertFavoriteMovieRepository.self)!
      )
    }
    
    container.register(DeleteFavoriteMovieUseCase.self) { resolver in
      DeleteFavoriteMovieUseCase(repository: resolver.resolve(DeleteFavoriteMovieRepository.self)!
      )
    }
    
    container.register(CheckIsFavoriteMovieUseCase.self) { resolver in
      CheckIsFavoriteMovieUseCase(repository: resolver.resolve(CheckIsFavoriteMovieRepository.self)!
      )
    }
    
    // MARK: - ViewModel
    container.register(DetailViewModel.self) { resolver in
      DetailViewModel(
        moviesDetailUseCase: resolver.resolve(GetMovieDetailUseCase.self)!,
        casterMovieUseCase: resolver.resolve(GetMovieCasterUseCase.self)!,
        insertMovieToFavoriteUseCase: resolver.resolve(InsertFavoriteMovieUseCase.self)!,
        checkIsFavoriteUseCase: resolver.resolve(CheckIsFavoriteMovieUseCase.self)!,
        deleteMovieFromFavoriteUseCase: resolver.resolve(DeleteFavoriteMovieUseCase.self)!
      )
    }
    
    // MARK: - ViewController
    container.register(DetailViewController.self) { resolver in
      let viewModel = resolver.resolve(DetailViewModel.self)!
      return DetailViewController(viewModel: viewModel)
    }
    
    return container
  }()
}
