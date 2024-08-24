//
//  User.swift
//  TrackIt
//
//  Created by Student11 on 18/08/2024.
//

class User: Codable{
    var username: String
    var userImage: String // url to user image
    var movieList: [MovieListItem]?
    
    init(username: String, userImage: String, movieList: [MovieListItem]?=nil) {
        self.username = username
        self.userImage = userImage
        self.movieList = movieList
    }
    
    enum CodingKeys: String, CodingKey {
        case username
        case userImage
        case movieList
    }
}
