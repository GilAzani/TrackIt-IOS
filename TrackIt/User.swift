//
//  User.swift
//  TrackIt
//
//  Created by Student11 on 18/08/2024.
//

class User{
    var username: String
    var userImage: String // url to user image
    var movieList: [MovieListItem]
    
    init(username: String, userImage: String, movieList: [MovieListItem]) {
        self.username = username
        self.userImage = userImage
        self.movieList = movieList
    }
}
