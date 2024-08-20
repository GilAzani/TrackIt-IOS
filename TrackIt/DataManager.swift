//
//  DataManager.swift
//  TrackIt
//
//  Created by Student11 on 20/08/2024.
//

import Foundation
import Alamofire

class DataManager{
    static let instance = DataManager()
    
    var movieList: [MovieListItem] = []
    let MOVIES_API_URL = "https://moviedatabase8.p.rapidapi.com/Search"
    
    // TODO load api key from .env to here
    let API_KEY = ""
    
    // TODO move to .env like file
    let headers: HTTPHeaders =  [
        "x-rapidapi-key": "API_KEY,",
        "x-rapidapi-host": "moviedatabase8.p.rapidapi.com"
    ]
    
    private init(){
        // TODO fetch user movies
    }
    
    func isMovieInList(movie: Movie) -> Bool{
        return movieList.contains(where: { $0.movie.id == movie.id })
    }
    
    func addMovie(movie: Movie){
        if isMovieInList(movie: movie){
            return
        }
        // default iLiked value is false
        movieList.append(MovieListItem(movie: movie, isLiked: false))
    }
    
    func removeMovie(movie: Movie) {
        if let index = movieList.firstIndex(where: { $0.movie.id == movie.id }) {
            movieList.remove(at: index)
        }
    }
    
    func searchMoviesByTitle(title: String, completion: @escaping ([Movie]) -> Void){
        let searchMovieURL = MOVIES_API_URL + "/\(title)"
        AF.request(searchMovieURL, headers: headers).responseDecodable(of: [Movie].self ){
            response in
            switch response.result{
            case .success(let movies):
                completion(movies)

            case .failure(let error):
                print("error: \(error)")
                completion([])
            }

        }

    }
    
}
