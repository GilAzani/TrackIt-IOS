//
//  User.swift
//  TrackIt
//
//  Created by Student11 on 18/08/2024.
//

class User: Codable{
    var username: String
    var movieList: [MovieListItem]?
    
    init(username: String, movieList: [MovieListItem]?=nil) {
        self.username = username
        self.movieList = movieList
    }
    
    enum CodingKeys: String, CodingKey {
        case username
        case movieList
    }
}
