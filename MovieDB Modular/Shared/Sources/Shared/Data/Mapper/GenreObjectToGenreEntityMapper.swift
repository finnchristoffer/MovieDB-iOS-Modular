//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 14/05/23.
//

import Core

public struct GenreObjectToGenreEntityMapper: Mapper {
  public typealias From = [GenreObject]
  public typealias To = [GenreEntity]
  
  public init() {}
  
  public func transform(from this: [GenreObject]) -> [GenreEntity] {
    return this.map { result in
      return GenreEntity(id: result.id, name: result.name)
    }
  }
}
