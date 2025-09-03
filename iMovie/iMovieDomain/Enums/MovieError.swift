//
//  MovieError.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

enum MovieError: Error {
    case serviceUnavailable
    case unexpected

    var errorDescription: String {
        switch self {
        case .serviceUnavailable:
            return "Serviço indisponível"
        case .unexpected:
            return "Houve um erro inesperado"
        }
    }
}
