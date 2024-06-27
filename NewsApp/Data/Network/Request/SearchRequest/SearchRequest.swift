//
//  EverythingRequest.swift
//  NewsApp
//
//  Created by tarek ahmed on 25/06/2024.
//

import Foundation

enum SearchRequest : RequestProtocol {
    case fetchEverthing(search:String,page:Int)
    
    var path: String {
        return "/v2/everything"
    }
    
    var urlParams: [String: String?] {
        var params: [String: String] = [:]
        switch self {
        case .fetchEverthing(let search,let page):
            params["q"] = search
            params["page"] = "\(page)"
            params["pageSize"] = "10"
        }
        return params
    }
    
    var requestType: RequestType {
        .GET
    }
}
