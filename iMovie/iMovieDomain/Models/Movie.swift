//
//  Movie.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

struct Movie: Codable {
    let id: Int
    let posterPath: String?
    let backdropPath: String?
    let title: String?
    let overview: String?
    let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case title
        case overview
        case releaseDate = "release_date"
    }
}
