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
            // TODO get list by text from data manager -> api
            searchResult = [Movie(id: 1, title: searchMovieTextFeild.text ?? "bug", releaseDate: "2019", overview: "gil", imageURL: "https://image.tmdb.org/t/p/original//zvwBd0nsW5OqTs4ndEJLQY62leF.jpg", runtime: 100), Movie(id: 2, title: "gil", releaseDate: "2019", overview: "gil", imageURL: "https://image.tmdb.org/t/p/original//zvwBd0nsW5OqTs4ndEJLQY62leF.jpg", runtime: 100)]
            movieTableView.reloadData()
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

        let imageURL = URL(string: movie.imageURL)!

        cell?.movieImageView.af.setImage(withURL: imageURL, placeholderImage: #imageLiteral(resourceName: "default_movie_icon")) //add default image
                
        cell?.movieNameLabel.text = movie.title
        return cell!
    }
    
    
}
