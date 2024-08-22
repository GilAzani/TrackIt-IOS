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
    
    // Computed property for API_KEY
    private var API_KEY: String {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let config = NSDictionary(contentsOfFile: path),
              let apiKey = config["API_KEY"] as? String else {
            fatalError("API_KEY not found in Config.plist")
        }
        return apiKey
    }


    // Computed property for headers
    private var headers: HTTPHeaders {
        return [
            "x-rapidapi-key": API_KEY,
            "x-rapidapi-host": "moviedatabase8.p.rapidapi.com"
        ]
    }
    
    private init() {
        // TODO: Fetch user movies
        print(API_KEY)
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
