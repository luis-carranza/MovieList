//
//  ContentView.swift
//  MovieList
//
//  Created by Luis Javier Carranza on 24/05/21.
//

import SwiftUI
import Foundation
import URLImage


struct ContentView: View {
    @ObservedObject var movieService = MovieService()
    @State var image: UIImage = UIImage()
    
    var body: some View {
        
        NavigationView {
            List (movieService.movies, id: \.id) { movie in
               
                URLImage((URL(string: "https://image.tmdb.org/t/p/w500/\(movie.poster_path)") ?? URL(string: "https://via.placeholder.com/80X100"))!) {
                    image in image.resizable().clipped().frame(width: 80, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                VStack(alignment: .leading) {
                    Text(movie.title)
                    Text(getNumber(number: movie.vote_average))
                }
               
            }
            .navigationBarTitle("Popular Movies", displayMode: .inline)
        }
        .onAppear(perform: {
            movieService.getData()
        })
    }
    
    
    
    func getNumber (number: Float) -> String {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number)) ?? "0.0"
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
