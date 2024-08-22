//
//  MyMoviesViewController.swift
//  TrackIt
//
//  Created by Student11 on 19/08/2024.

import UIKit

class MyMoviesViewController: UIViewController {
    
    @IBOutlet weak var moviesTableView: UITableView!
    let movieCellId = "movie_cell_id"
    var movieList: [MovieListItem] = []
    var displayList: [MovieListItem] = []
    var showLiked: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initList()
        
        connectList()
    }
    
    func connectList(){
        displayList = movieList
        
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.reloadData()
    }
    
    func initList(){
        movieList = DataManager.instance.movieList
        
    }
    
    @IBAction func showAllMovies(_ sender: Any) {
        // Update displayList to show all movies
        displayList = movieList
        moviesTableView.reloadData()
    }
    @IBAction func showFavoriteMovies(_ sender: Any) {
        // Update displayList to show only favorite movies
        displayList = movieList.filter { $0.isLiked }
        moviesTableView.reloadData()
    }
}

extension MyMoviesViewController: UITableViewDelegate {
    
}

extension MyMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movieCellId, for: indexPath) as! LikeableMovieCell
        
        let movieItem = displayList[indexPath.row]
        cell.movieNameLabel.text = movieItem.movie.title
        
        
        let posterImageURL = URL(string: movieItem.movie.imageURL.isEmpty ? "https://" : movieItem.movie.imageURL)!

        cell.moviePosterImageView.af.setImage(withURL: posterImageURL, placeholderImage: #imageLiteral(resourceName: "default_movie_icon"))
        // Configure the initial image
        updateLikeImageView(for: cell, at: indexPath)
        
        // Add a tap gesture recognizer to the likeImageView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLikeImageTap(_:)))
        cell.likeImageView.isUserInteractionEnabled = true
        cell.likeImageView.addGestureRecognizer(tapGesture)
        
        // Store the indexPath in the gesture recognizer's view to identify which cell was tapped
        tapGesture.view?.tag = indexPath.row
        
        return cell
    }
    
    @objc private func handleLikeImageTap(_ sender: UITapGestureRecognizer) {
        guard let tappedImageView = sender.view as? UIImageView else { return }
        let indexPath = IndexPath(row: tappedImageView.tag, section: 0)
        
        let movieItem = displayList[indexPath.row]
        
        var updatedMovieItem = movieItem
        updatedMovieItem.isLiked.toggle()
        
        // Update movieList
        if let indexInMovieList = movieList.firstIndex(where: { $0.movie.id == movieItem.movie.id }) {
            movieList[indexInMovieList] = updatedMovieItem
        }
                
        // Update displayList
        displayList[indexPath.row] = updatedMovieItem
        
        // Update the cell to reflect the change
        if let cell = moviesTableView.cellForRow(at: indexPath) as? LikeableMovieCell {
            updateLikeImageView(for: cell, at: indexPath)
        }
    
        
        moviesTableView.reloadData()
    }
    
    private func updateLikeImageView(for cell: LikeableMovieCell, at indexPath: IndexPath) {
        let movieItem = displayList[indexPath.row]
        let imageName = movieItem.isLiked ? "hand.thumbsup.fill" : "hand.thumbsup"
        cell.likeImageView.image = UIImage(systemName: imageName)
    }
}
