//
//  ProfileViewController.swift
//  TrackIt
//
//  Created by Student11 on 18/08/2024.
//
import UIKit
import AlamofireImage

class ProfileViewController: UIViewController {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var favoriteMoviesTableView: UITableView!
    @IBOutlet weak var numberOfMoviesLabel: UILabel!
    
    @IBOutlet weak var favoriteMoviesLabel: UILabel!
    let movieListLabel = "Favorite Movies List:"
    
    let movieCellId = "favorite_movie_id"
    
    var userData: User!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadUserData()
        
        loadUI()
        
        connectFavoriteMovieList()
    }
    
    func connectFavoriteMovieList(){
        favoriteMoviesTableView.dataSource = self
        favoriteMoviesTableView.delegate = self
        favoriteMoviesTableView.reloadData()
    }
    
    func loadUI(){
        let imageURL = URL(string: userData.userImage)!
        // add a placeholder image later
        userImageView.af.setImage(withURL: imageURL)
        usernameLabel.text = userData.username

        refreshMovieCount()
    }
    
    func refreshMovieCount(){
        
        let movieCount = userData.movieList.count
        if movieCount == 1{
            numberOfMoviesLabel.text = "1 movie"
        }else{
            numberOfMoviesLabel.text = "\(movieCount) movies"
        }
    }
    
    func refreshMovieLabel(){
        let favoriteMovies = userData.movieList.filter {$0.isLiked}
        if favoriteMovies.isEmpty{
            favoriteMoviesLabel.text = ""
        }else{
            favoriteMoviesLabel.text = movieListLabel
        }
    }

    func loadUserData(){
        // later getting the data from datamanager
        self.userData = User(username: "gil", userImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWo3luud5KPZknLR5zdUUwzvYBztWgTxrkbA&s", movieList:DataManager.instance.movieList )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        userData.movieList = DataManager.instance.movieList
        favoriteMoviesTableView.reloadData()
        refreshMovieCount()
        refreshMovieLabel()
    }

}

extension ProfileViewController: UITableViewDelegate{
    
}

extension ProfileViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let favoriteMovies = userData.movieList.filter {$0.isLiked}
        return favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: SimpleMovieCell? = favoriteMoviesTableView.dequeueReusableCell(withIdentifier: movieCellId) as! SimpleMovieCell

        let favoriteMovies = userData.movieList.filter {$0.isLiked}
        let movie: Movie = favoriteMovies[indexPath.row].movie

        let imageURL = URL(string: movie.imageURL.isEmpty ? "https://" : movie.imageURL)!

        cell?.movieImageView.af.setImage(withURL: imageURL, placeholderImage: #imageLiteral(resourceName: "default_movie_icon")) //add default image
                
        cell?.movieNameLabel.text = movie.title
        return cell!
    }


}

