//
//  Trailer.swift
//  TP2
//
//  Created by digital on 18/04/2023.
//

import Foundation

struct Trailer {
    let key: String
    let site: String
    
    init(dto: TrailerDTO) {
        self.key = dto.key!
        self.site = dto.site!
    }
}
