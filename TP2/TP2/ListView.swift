//
//  ListView.swift
//  TP2
//
//  Created by digital on 22/05/2023.
//

import Foundation
import SwiftUI


struct ListView: View {
    @State var movies: [Movie] = []
    @State var categories: [Genre] = []
    @State var selectedCategory: Int = -1
    @EnvironmentObject var viewModel : ViewModel
    
    var body: some View {
        NavigationView{
            ScrollView {
                Picker("film-list.all-categories", selection: $selectedCategory){
                    Text("film-list.all-categories").tag(-1)
                    ForEach(viewModel.categories) { categorie in
                        Text(categorie.name).tag(categorie.id)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .onChange(of: selectedCategory){ categorieId in
                    print(categorieId)
                    if categorieId != -1 {
                        viewModel.getMoviesByGenre(categorie: categorieId)
                    } else {
                        viewModel.getMovies()
                    }
                }
                ForEach(viewModel.movies, id: \.self) { movie in
                    NavigationLink(
                        destination:ContentView(movieid: movie.id)){
                            AsyncImage(url: URL(string: movie.affiche)) { image in
                                if let img = image.image {
                                    img
                                        .resizable()
                                        .frame(width: 200, height: 350)
                                        .border(Color.black)
                                }
                            }
                            Text(movie.titre).font(.title)
                        }
                }
            }
        }.onAppear{
            viewModel.getMovies()
            viewModel.fetchCat()
            print(viewModel)
            
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
