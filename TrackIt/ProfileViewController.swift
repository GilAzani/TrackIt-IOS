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
        
        let movieCount = userData.movieList.count
        if movieCount == 1{
            numberOfMoviesLabel.text = "1 movie"
        }else{
            numberOfMoviesLabel.text = "\(movieCount) movies"
        }
    }

    func loadUserData(){
        // later getting the data from datamanager
        self.userData = User(username: "gil", userImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWo3luud5KPZknLR5zdUUwzvYBztWgTxrkbA&s", movieList: [MovieListItem(movie: Movie(title: "gil", releaseDate: "2019", overview: "gil", imageURL: "https://image.tmdb.org/t/p/original//zvwBd0nsW5OqTs4ndEJLQY62leF.jpg", runtime: 100), isLiked: true), MovieListItem(movie: Movie(title: "gil", releaseDate: "2019", overview: "gil", imageURL: "https://image.tmdb.org/t/p/original//zvwBd0nsW5OqTs4ndEJLQY62leF.jpg", runtime: 100), isLiked: true)] )
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

        let imageURL = URL(string: movie.imageURL)!

        cell?.movieImageView.af.setImage(withURL: imageURL, placeholderImage: #imageLiteral(resourceName: "default_movie_icon")) //add default image
                
        cell?.movieNameLabel.text = movie.title
        return cell!
    }


}

