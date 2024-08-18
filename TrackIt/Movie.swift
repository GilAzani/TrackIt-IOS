//
//  Movie.swift
//  TrackIt
//
//  Created by Student11 on 18/08/2024.
//

import Foundation

class Movie{
    var title: String
    var releaseDate: String
    var overview: String
    var imageURL: String
    var runtime: Int //duration in minutes
    
    init(title: String, releaseDate: String, overview: String, imageURL: String, runtime: Int) {
        self.title = title
        self.releaseDate = releaseDate
        self.overview = overview
        self.imageURL = imageURL
        self.runtime = runtime
    }
    
    enum CodingKeys: String, CodingKey{
        case titles
        case releaseDate = "release_date"
        case overview
        case imageURL = "poster_path"
        case runtime
    }
}
