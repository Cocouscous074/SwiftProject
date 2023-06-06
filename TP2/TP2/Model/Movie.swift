//
//  Films.swift
//  TP2
//
//  Created by digital on 17/04/2023.
//

import SwiftUI

struct Movie: Hashable {
    let id: Int
    let titre: String
    let dateSortie: String
    let duree: Int
    let categories: [Genre]
    let synopsis: String
    let affiche: String
    var trailer: String
    
    init(dto: MovieDTO) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        
        self.id = dto.id!
        
        if let titre = dto.title {
            self.titre = titre
        }else{
            self.titre = ""
        }
        
        if let dateSortie = dto.release_date {
            self.dateSortie = dateSortie
        }else{
            self.dateSortie = ""
        }
        
        if let duree = dto.runtime {
            self.duree = duree
        }else{
            self.duree = 0
        }
        
        if let categories = dto.runtime {
            self.categories = dto.genres!.map{genre in
                return Genre(id: genre.id ?? 0, name: genre.name ?? "")
            }
        }else{
            self.categories = []
        }
        
        if let synopsis = dto.overview {
            self.synopsis = synopsis
        }else{
            self.synopsis = ""
        }
        
        if let affiche = dto.poster_path {
            self.affiche = "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/" + affiche
        }else{
            self.affiche = ""
        }
        
        self.trailer = "https://www.youtube.com/watch?v="
    }
}
