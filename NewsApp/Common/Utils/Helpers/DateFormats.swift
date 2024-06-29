//
//  DateFormats.swift
//  NewsApp
//
//  Created by tarek ahmed on 23/06/2024.
//

import Foundation

enum DateFormats {
    /// yyyy-MM-dd'T'HH:mm:ssZ
    /// 2024-06-21T21:14:38Z
    case fullFormat
    
    var stringValue : String {
        switch self {
        case .fullFormat:
              return "yyyy-MM-dd'T'HH:mm:ssZ"
        }
    }
}
