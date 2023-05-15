//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 14/05/23.
//

import Core

public struct CastResponsesToDomainsMapper: Mapper {
  public typealias From = [CastModel]
  public typealias To = [Cast]
  
  public init() {}
  
  public func transform(from this: [CastModel]) -> [Cast] {
    return this.map { result in
      return Cast(
        adult: result.adult,
        gender: result.gender,
        id: result.id,
        knownForDepartment: result.knownForDepartment,
        name: result.name,
        originalName: result.originalName,
        popularity: result.popularity,
        profilePath: result.profilePath,
        castID: result.castID,
        character: result.character,
        creditID: result.creditID,
        order: result.order,
        department: result.department,
        job: result.job)
    }
  }
}
