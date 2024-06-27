//
//  HeadLinesRequest.swift
//  NewsApp
//
//  Created by tarek ahmed on 22/06/2024.
//

import Foundation

enum HeadLinesRequest : RequestProtocol {
    case fetchHeadLines
    
    var path: String {
        switch self {
        case .fetchHeadLines:
            return "/v2/top-headlines"
        }
    }
    
    var urlParams: [String: String?] {
        switch self {
        case .fetchHeadLines:
            var params: [String: String] = [:]
            params["country"] = "us"
            return params
        }
    }
    
    var requestType: RequestType {
        .GET
    }
}
