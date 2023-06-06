//
//  ViewModel.swift
//  TP2
//
//  Created by digital on 23/05/2023.
//

import Foundation

class ViewModel:ObservableObject{
    @Published var movies: [Movie] = []
    @Published var categories: [Genre] = []
    
    private func fetchMovieList(urlString: String){
        self.movies = []
        
        guard let url = URL(string: urlString) else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { ndata,response,error in
            if let data = ndata {
                let decoder = JSONDecoder()
                do {
                    let decoded = try decoder.decode(MovieResultDTO.self, from: data)
                    DispatchQueue.main.async {
                        decoded.results!.forEach{ movie in
                            self.movies.append(Movie(dto: movie))
                        }
                    }
                } catch{
                    print("erreur")
                }
            }
        }
        task.resume()
    }
    
    func fetchCat(){
        let bURL = "\(baseUrl)/genre/movie/list?api_key=\(apikey)&language=\(language)"
        
        guard let url = URL(string: bURL) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let data = data {
                let decoder = JSONDecoder()
                
                do{
                    let decode = try decoder.decode(GenreResultDTO.self, from: data)
                    DispatchQueue.main.async {
                        decode.genres.forEach{catDTO in
                            self.categories.append(Genre(dto: catDTO))
                        }
                        
                    }
                    
                }catch{
                    print("fail decode")
                }
                
            }
            
            
        }
        task.resume()
        
    }
    
    func getMovies(){
        let url = "\(baseUrl)/movie/now_playing?api_key=\(apikey)&language=\(language)&append_to_response=videos"
        self.fetchMovieList(urlString: url)
    }
    
    
    func getMoviesByGenre(categorie:Int){
        print(categorie)
        let url = "\(baseUrl)/discover/movie?api_key=\(apikey)&language=\(language)&with_genres=\(categorie)"
        self.fetchMovieList(urlString: url)
        
        
    }
    
    func fetchMovie(id: Int) async -> Movie?{
        let movieDetailsURL = "\(baseUrl)/movie/\(id)?api_key=\(apikey)&language=\(language)"
        
        guard let url = URL(string: movieDetailsURL) else {
            print("Invalid URL")
            return nil;
        }
        do {
            let (data,_) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            
            do {
                var dtoMovie = try decoder.decode(MovieDTO.self, from: data)
                dtoMovie.id = id
                var movie = Movie(dto: dtoMovie)
                
                let trailerURL = "\(baseUrl)/movie/\(id)/videos?api_key=\(apikey)&language=\(language)"
                guard let url = URL(string: trailerURL) else {
                    print("Invalid URL for trailer")
                    return nil;
                }
                let (data,_) = try await URLSession.shared.data(from: url)
                do {
                    let dtoTrailer = try decoder.decode(ResultTrailerDTO.self, from: data)
                    if let trailer = dtoTrailer.results.filter({ $0.site == "YouTube" }).first {
                        movie.trailer += trailer.key ?? ""
                    }
                } catch {
                    print("Failed to decode trailer JSON: \(error)")
                }
                return movie;
            }
        }catch {
            print("Failed to decode JSON: \(error)")
        }
        return nil;
    }
}
