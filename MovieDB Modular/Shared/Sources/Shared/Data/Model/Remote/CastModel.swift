//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 13/05/23.
//

import Foundation

// MARK: - CastResponse
public struct CastResponse: Codable {
  public let id: Int?
  public let cast, crew: [CastModel]?
}

// MARK: - Cast
public struct CastModel: Codable {
  public let adult: Bool?
  public let gender, id: Int?
  public let knownForDepartment, name, originalName: String?
  public let popularity: Double?
  public let profilePath: String?
  public let castID: Int?
  public let character, creditID: String?
  public let order: Int?
  public let department, job: String?
  
  enum CodingKeys: String, CodingKey {
    case adult, gender, id
    case knownForDepartment = "known_for_department"
    case name
    case originalName = "original_name"
    case popularity
    case profilePath = "profile_path"
    case castID = "cast_id"
    case character
    case creditID = "credit_id"
    case order, department, job
  }
}
