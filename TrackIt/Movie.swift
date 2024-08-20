//
//  Movie.swift
//  TrackIt
//
//  Created by Student11 on 18/08/2024.
//

import Foundation

class Movie{
    var id: Int
    var title: String
    var releaseDate: String
    var overview: String
    var imageURL: String
    var runtime: Int //duration in minutes
    
    init(id: Int, title: String, releaseDate: String, overview: String, imageURL: String, runtime: Int) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.overview = overview
        self.imageURL = imageURL
        self.runtime = runtime
    }
    
    enum CodingKeys: String, CodingKey{
        case id
        case title
        case releaseDate = "release_date"
        case overview
        case imageURL = "poster_path"
        case runtime
    }
    
    func getPrettyTimeString() -> String{
        let hours = runtime / 60
        let minutes = runtime % 60
        var result = "\(runtime) minutes"
        
        if hours > 0{
            result += " - \(hours)h \(minutes)m"
        }
        return result
    }
}
