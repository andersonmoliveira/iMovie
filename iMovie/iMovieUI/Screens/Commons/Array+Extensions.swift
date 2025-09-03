//
//  Array+Extensions.swift
//  iMovie
//
//  Created by Anderson Oliveira on 03/09/25.
//

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
