//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 16/05/23.
//

import Shared
import Swinject
import RealmSwift

public class FavoriteModule {
  public init() {}
  
  public let container: Container = {
    let container = Container()
    // MARK: - DataSource
    container.register(GetListFavoriteMovieDataSource.self) { _ in
      GetListFavoriteMovieDataSource(realm: try! Realm())
    }
    
    // MARK: - Repository
    container.register(GetListFavoriteMovieRepository.self) { resolver in
      GetListFavoriteMovieRepository(
        localDataSource: resolver.resolve(GetListFavoriteMovieDataSource.self)!,
        mapper: SharedModule().container.resolve(MovieObjectToMovieEntityMapper.self)!
      )
    }
    
    // MARK: - UseCase
    container.register(GetListFavoriteMovieUseCase.self) { resolver in
      GetListFavoriteMovieUseCase(repository: resolver.resolve(GetListFavoriteMovieRepository.self)!
      )
    }
    
    // MARK: - ViewModel
    container.register(FavoriteViewModel.self) { resolver in
      FavoriteViewModel(movieFavoriteUseCase: resolver.resolve(GetListFavoriteMovieUseCase.self)!
      )
    }
    
    // MARK: - ViewController
    container.register(FavoriteViewController.self) { resolver in
      let viewModel = resolver.resolve(FavoriteViewModel.self)!
      return FavoriteViewController(viewModel: viewModel)
    }
    
    return container
  }()
}
