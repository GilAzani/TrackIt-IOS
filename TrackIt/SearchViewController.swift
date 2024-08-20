//
//  SearchViewController.swift
//  TrackIt
//
//  Created by Student11 on 20/08/2024.
//

import Foundation

import UIKit

class SearchViewController: UIViewController {
    let searchMovieCellId = "search_movie_cell"
    let showDetailedMovieSegueId = "show_movie_details"
    
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var searchMovieTextFeild: UITextField!
    
    var searchResult: [Movie] = []
    var selectedMovie: Movie!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpList()
    }
    @IBAction func searchMovie(_ sender: Any) {
        if !searchMovieTextFeild.hasText{
            searchResult = []
            movieTableView.reloadData()
        }else{
            DataManager.instance.searchMoviesByTitle(title: searchMovieTextFeild.text!){
                list in
                self.searchResult = list
                self.movieTableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showDetailedMovieSegueId{
            // TODO get movie state from data manager - not/is in the list
            let detailedMovie = segue.destination as! DetailedMovieViewController
            detailedMovie.isAdded = true
            detailedMovie.movie = selectedMovie
        }
    }
    
    func setUpList(){
        movieTableView.dataSource = self
        movieTableView.delegate = self
    }
}

extension SearchViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMovie = searchResult[indexPath.row]
        performSegue(withIdentifier: showDetailedMovieSegueId, sender: self)
    }
    
}

extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: SimpleMovieCell? = movieTableView.dequeueReusableCell(withIdentifier: searchMovieCellId) as! SimpleMovieCell

        let movie: Movie = searchResult[indexPath.row]

        let imageURL = URL(string: movie.imageURL.isEmpty ? "https://" : movie.imageURL)!

        cell?.movieImageView.af.setImage(withURL: imageURL, placeholderImage: #imageLiteral(resourceName: "default_movie_icon"))

                
        cell?.movieNameLabel.text = movie.title
        return cell!
    }
    
    
}
