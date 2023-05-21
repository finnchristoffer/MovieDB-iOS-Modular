//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 13/05/23.
//

import Foundation

public struct API {
  static let baseUrl = "https://api.themoviedb.org/3/"
  public static let baseUrlImage = "https://image.tmdb.org/t/p/original"
  static let apiKey = apiKeyValue
}

public protocol Endpoint {
  var url: String { get }
}

public enum Endpoints {
  
  public enum Get: Endpoint {
    case upcoming
    case now
    case popular
    case search(query: String)
    case movie(id: Int)
    case movieCast(id: Int)
    
    public var url: String {
      switch self {
      case .upcoming: return "\(API.baseUrl)movie/upcoming?api_key=\(API.apiKey)"
      case .now: return "\(API.baseUrl)movie/now_playing?api_key=\(API.apiKey)"
      case .popular: return "\(API.baseUrl)movie/popular?api_key=\(API.apiKey)"
      case .search(let query): return "\(API.baseUrl)search/movie?api_key=\(API.apiKey)&query=\(query)"
      case .movie(let id): return "\(API.baseUrl)movie/\(id)?api_key=\(API.apiKey)"
      case .movieCast(let id): return "\(API.baseUrl)movie/\(id)/credits?api_key=\(API.apiKey)"
      }
    }
  }
}

private var apiKeyValue: String {
  get {
    guard let filePath = Bundle.main.path(forResource: "TMDB-Info", ofType: "plist") else {
      fatalError("Couldn't find file 'TMDB-Info.plist'.")
    }
    
    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "API_KEY") as? String else {
      fatalError("Couldn't find key 'API_KEY' in 'TMDB-Info.plist'.")
    }
    
    if (value.starts(with: "_")) {
      fatalError("Register for a TMDB developer account and get an API key at https://developers.themoviedb.org/3/getting-started/introduction.")
    }
    
    return value
  }
}
