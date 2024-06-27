//
//  CustomDecodingError.swift
//  NewsApp
//
//  Created by tarek ahmed on 22/06/2024.
//

import Foundation

enum CustomDecodingError : Error {
    case paringError
    case unknown

    public var errorDescription: String? {
      switch self {
      case .paringError:
        return "Parsing Error.."
      case .unknown :
        return "UnKnown error..."
      }
    }
    
}
