//
//  MovieRequest.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

import CoreNetwork

enum MovieRequest: Request {
    
    case trending(page: Int)
    
    var host: String {
        switch self {
        case .trending:
            return "api.themoviedb.org"
        }
    }
    
    var scheme: String { "https" }
    
    var version: String { "/3" }
    
    var path: String {
        switch self {
        case .trending:
            return "/trending/movie/day"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .trending:
            return .get
        }
    }
    
    var headers: [String : String]? { nil }
    
    var bodyParams: [String : Any?]? { nil }
    
    var queryParams: [String : String]? {
        var params: [String: String] = [
            "language": "pt-BR",
            "api_key": AppConfig.apiKey
        ]
        switch self {
        case .trending(let page):
            params["page"] = String(page)
            return params
        }
    }
}
