//
//  MovieService.swift
//  MovieList
//
//  Created by Luis Javier Carranza on 24/05/21.
//

import Foundation

class MovieService: ObservableObject {
    
    @Published var movies = [Movie]()
    
    func getData() {
        
        if let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=89db676e08b3729fa899366e9ee46f2f&language=en-US&page=1") {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response , error in
                 
                if(error == nil) {
                    let decoder = JSONDecoder()
                    if let unwrappedData = data {
                        do{
                            let results = try decoder.decode(MovieList.self, from: unwrappedData)
                            DispatchQueue.main.async {
                                self.movies = results.results
                            }
                            
                        }catch {
                            print(error)
                        }
                    }
                }
                else {
                    print("This is the Error \(error!)")
                }
                
            }
            task.resume()
        }
    }
}



