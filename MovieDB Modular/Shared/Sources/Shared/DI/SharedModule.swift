//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 14/05/23.
//

import Swinject

public class SharedModule {
  public init() {}
  
  public let container: Container = {
    let container = Container()
    
    // MARK: Mapper
    container.register(MovieResponsesToEntityMapper.self) { _ in
      MovieResponsesToEntityMapper()
    }
    
    container.register(MovieResponseToEntityMapper.self) { _ in
      MovieResponseToEntityMapper()
    }
    
    container.register(MovieObjectToMovieEntityMapper.self) { _ in
      MovieObjectToMovieEntityMapper()
    }
    
    container.register(CastResponsesToDomainsMapper.self) { _ in
      CastResponsesToDomainsMapper()
    }
    
    container.register(GenreObjectToGenreEntityMapper.self) { _ in
      GenreObjectToGenreEntityMapper()
    }
    
    container.register(MovieEntityToObjectMapper.self) { _ in
      MovieEntityToObjectMapper()
    }
    
    return container
  }()
}
