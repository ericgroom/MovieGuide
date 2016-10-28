//
//  Movie.swift
//  Movie Guide
//
//  Created by Eric Groom on 10/27/16.
//  Copyright © 2016 Eric Groom. All rights reserved.
//

import UIKit

let baseImageURL = "http://image.tmdb.org/t/p/w500"

class Movie: NSObject {
    
    var moviePosterUrl: URL?
    var movieTitle: String?
    var movieOverview: String?
    var movieBackdropPathUrl: URL?
    
    init(dictionary: NSDictionary) {
        
        if let moviePosterUrlString = dictionary["poster_path"] as? String {
            moviePosterUrl = URL(string: baseImageURL + moviePosterUrlString)!
        } else {
            moviePosterUrl = nil
        }
        
        if let movieBackdropPathString = dictionary["backdrop_path"] as? String {
            movieBackdropPathUrl = URL(string: baseImageURL + movieBackdropPathString)!
        } else {
            movieBackdropPathUrl = nil
        }
        
        self.movieTitle = dictionary["title"] as? String
        
        self.movieOverview = dictionary["overview"] as? String
    }

    class func movies(array: [NSDictionary]) -> [Movie] {
        var movies = [Movie]()
        for dictionary in array {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        return movies
    }
}
