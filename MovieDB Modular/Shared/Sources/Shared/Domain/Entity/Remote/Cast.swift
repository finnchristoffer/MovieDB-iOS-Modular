//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 13/05/23.
//

import Foundation

public struct Cast: Equatable, Identifiable {
  public let adult: Bool?
  public let gender, id: Int?
  public let knownForDepartment, name, originalName: String?
  public let popularity: Double?
  public let profilePath: String?
  public let castID: Int?
  public let character, creditID: String?
  public let order: Int?
  public let department, job: String?

  public init(adult: Bool?, gender: Int?, id: Int?, knownForDepartment: String?, name: String?, originalName: String?, popularity: Double?, profilePath: String?, castID: Int?, character: String?, creditID: String?, order: Int?, department: String?, job: String?) {
    self.adult = adult
    self.gender = gender
    self.id = id
    self.knownForDepartment = knownForDepartment
    self.name = name
    self.originalName = originalName
    self.popularity = popularity
    self.profilePath = profilePath
    self.castID = castID
    self.character = character
    self.creditID = creditID
    self.order = order
    self.department = department
    self.job = job
  }
}
