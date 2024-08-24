//
//  MovieListItem.swift
//  TrackIt
//
//  Created by Student11 on 18/08/2024.
//

import Foundation

class MovieListItem: Codable{
    var movie: Movie
    var isLiked: Bool = false
    
    init(movie: Movie, isLiked: Bool) {
        self.movie = movie
        self.isLiked = isLiked
    }
    
    enum CodingKeys: String, CodingKey {
        case movie
        case isLiked

    }
}
