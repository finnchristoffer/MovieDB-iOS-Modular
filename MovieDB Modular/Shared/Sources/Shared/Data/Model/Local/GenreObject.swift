//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 13/05/23.
//

import RealmSwift

public class GenreObject: Object {
  @Persisted public var id: Int = 0
  @Persisted public var name: String = ""
  
  public convenience init(
    id: Int,
    name: String
  ) {
    self.init()
    self.id = id
    self.name = name
  }
}
