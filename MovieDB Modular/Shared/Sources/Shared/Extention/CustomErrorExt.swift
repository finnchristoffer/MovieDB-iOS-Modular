//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 13/05/23.
//

import Foundation

public enum URLError: LocalizedError {
  case invalidResponse
  case adressUnreachable(URL)
  
  public var errorDescription: String? {
    switch self {
    case .invalidResponse: return "The server responded with garbage."
    case .adressUnreachable(let url): return "\(url.absoluteString) is unreachable"
    }
  }
}

public enum DatabaseError: LocalizedError {
  case invalidInstance
  case requestFailed
  
  public var errorDescription: String? {
    switch self {
    case .invalidInstance: return "Database can't instance."
    case .requestFailed: return "Your request failed."
    }
  }
}
