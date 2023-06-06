//
//  Genre.swift
//  TP2
//
//  Created by digital on 17/04/2023.
//

import Foundation

struct Genre: Codable, Hashable, Identifiable{
    let id: Int
    let name: String
    
    init(id:Int, name:String) {
        self.id = id
        self.name = name
    }
    
    init(dto: GenreDTO) {
        self.id = dto.id
        if let name = dto.name {
            self.name = name
        }else{
            self.name = ""
        }
    }
}
