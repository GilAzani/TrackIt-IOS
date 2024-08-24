//
//  DataManager.swift
//  TrackIt
//
//  Created by Student11 on 20/08/2024.
//

import Foundation
import Alamofire
import FirebaseAuth
import FirebaseDatabase

class DataManager{
    static let instance = DataManager()
    
    var movieList: [MovieListItem] = []
    let MOVIES_API_URL = "https://moviedatabase8.p.rapidapi.com/Search"
    var currentUser: User?
    
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
        loadUserData()
    }
    
    func loadUserData() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("No user is currently signed in.")
            return
        }
        
        let databaseRef = Database.database().reference().child("users").child(uid)
        databaseRef.observeSingleEvent(of: .value) { snapshot in
            guard let userData = snapshot.value as? [String: Any] else {
                print("No user data found.")
                return
            }

            do {
                let jsonData = try JSONSerialization.data(withJSONObject: userData)
                let user = try JSONDecoder().decode(User.self, from: jsonData)
                self.currentUser = user
                self.movieList = user.movieList ?? []
                print("User data loaded successfully.")
            } catch {
                print("Error decoding user data: \(error)")
            }
        }
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
        currentUser?.movieList = movieList
        updateUserDataInDatabase()
    }
    
    func removeMovie(movie: Movie) {
        if let index = movieList.firstIndex(where: { $0.movie.id == movie.id }) {
            movieList.remove(at: index)
            currentUser?.movieList = movieList
            updateUserDataInDatabase()
        }
    }
    
    func updateUserDataInDatabase() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let userRef = Database.database().reference().child("users").child(userId)
        
        do {
            // Convert userData to dictionary using JSONEncoder and JSONSerialization
            let userDataEncoded = try JSONEncoder().encode(currentUser)
            let userDataDict = try JSONSerialization.jsonObject(with: userDataEncoded, options: []) as? [String: Any]
            
            // Update the Firebase database
            userRef.setValue(userDataDict)
        } catch let error {
            print("Failed to update user data: \(error.localizedDescription)")
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
