//
//  MyMoviesViewController.swift
//  TrackIt
//
//  Created by Student11 on 19/08/2024.

import UIKit

class MyMoviesViewController: UIViewController {
    
    var movieList: [MovieListItem] = []
    var displayList: [MovieListItem] = []
    var showFavorite: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initList()
    }
    
    func initList(){
        
    }
    
    @IBAction func showAllMovies(_ sender: Any) {
    }
    @IBAction func showFavoriteMovies(_ sender: Any) {
    }
}
