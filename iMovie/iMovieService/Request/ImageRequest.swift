//
//  ImageRequest.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

import CoreNetwork

enum ImageRequest: Request {

    case download(name: String)
    
    var host: String {
        "image.tmdb.org"
    }
    
    var scheme: String {
        "https"
    }
    
    var version: String { "" }
    
    var path: String {
        switch self {
        case .download(let name):
            return "/t/p/w200\(name)"
        }
    }
    
    var method: HTTPMethod { .get }
    
    var headers: [String : String]? {
        nil
    }
    
    var bodyParams: [String : Any?]? { nil }
    
    var queryParams: [String : String]? { nil }
}
