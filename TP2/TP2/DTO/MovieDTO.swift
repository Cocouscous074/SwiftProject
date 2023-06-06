//
//  API.swift
//  TP2
//
//  Created by digital on 17/04/2023.
//

import Foundation

struct MovieDTO: Decodable {
    var id: Int?
    let title: String?
    var release_date: String?
    let runtime: Int?
    let genres: [GenreDTO]?
    let overview: String?
    let poster_path: String?
}
