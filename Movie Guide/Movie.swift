//
//  Movie.swift
//  Movie Guide
//
//  Created by Eric Groom on 10/27/16.
//  Copyright © 2016 Eric Groom. All rights reserved.
//

import UIKit
import RealmSwift

let baseImageURL = "http://image.tmdb.org/t/p/w500"

class Movie: Object {
    
    dynamic var moviePosterUrl: String? = nil
    dynamic var movieTitle: String? = nil
    dynamic var movieOverview: String? = nil
    dynamic var movieBackdropPathUrl: String? = nil
    
    class func newMovie(dictionary: NSDictionary) -> Movie{
        
        let movie = Movie()
        
        if let moviePosterUrlString = dictionary["poster_path"] as? String {
            movie.moviePosterUrl = baseImageURL + moviePosterUrlString
        } else {
            movie.moviePosterUrl = nil
        }
        
        if let movieBackdropPathString = dictionary["backdrop_path"] as? String {
            movie.movieBackdropPathUrl = baseImageURL + movieBackdropPathString
        } else {
            movie.movieBackdropPathUrl = nil
        }
        
        movie.movieTitle = dictionary["title"] as? String
        
        movie.movieOverview = dictionary["overview"] as? String
        
        return movie
    }

    class func movies(array: [NSDictionary]) -> [Movie] {
        var movies = [Movie]()
        for dictionary in array {
            let movie = newMovie(dictionary: dictionary)
            
            //write the settings object to db for persistence
            try! realmObject.write() {
                realmObject.add(movie)
                print("New Movie saved with name: \(movie.movieTitle)")
                movies.append(movie)
            }
        }
        return movies
    }
}
