//
//  ProfileViewController.swift
//  TrackIt
//
//  Created by Student11 on 18/08/2024.
//
import UIKit
import AlamofireImage
import FirebaseAuth

class ProfileViewController: UIViewController {
    @IBOutlet weak var logoutImageView: UIImageView!
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
        
        setUpLogoutButton()

    }
    
    func setUpLogoutButton(){
        let logoutTapped = UITapGestureRecognizer(target: self, action: #selector(logout(_:)))
        logoutImageView.addGestureRecognizer(logoutTapped)
    }
    
    @objc func logout(_ sender: UITapGestureRecognizer){
        do {
            try Auth.auth().signOut()
            // Handle successful sign-out
            print("User successfully signed out.")
            
            // Optionally, navigate to the login screen or another screen
            navigateToLoginScreen()
        } catch let signOutError as NSError {
            // Handle sign-out error
            print("Error signing out: %@", signOutError.localizedDescription)
        }
    }
    
    func navigateToLoginScreen(){
        let mainAppStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let mainAppViewController = mainAppStoryboard.instantiateViewController(withIdentifier: "sign_in") as? SignInViewController {
            // Replace the root view controller with the main app view controller
            if let window = UIApplication.shared.windows.first {
                window.rootViewController = mainAppViewController
                window.makeKeyAndVisible()
            }
        }
    }
    
    func connectFavoriteMovieList(){
        favoriteMoviesTableView.dataSource = self
        favoriteMoviesTableView.delegate = self
        favoriteMoviesTableView.reloadData()
    }
    
    func loadUI(){
//        let imageURL = URL(string: userData.userImage.isEmpty ? "https://" : userData.userImage)!
//        userImageView.af.setImage(withURL: imageURL)
        usernameLabel.text = userData.username
        
        refreshMovieCount()
    }
    
    func refreshMovieCount(){
        
        let movieCount = userData.movieList?.count ?? 0
        if movieCount == 1{
            numberOfMoviesLabel.text = "1 movie"
        }else{
            numberOfMoviesLabel.text = "\(movieCount) movies"
        }
    }
    
    func refreshMovieLabel(){
        let favoriteMovies = userData.movieList?.filter {$0.isLiked}
        if ((favoriteMovies?.isEmpty) != nil){
            favoriteMoviesLabel.text = ""
        }else{
            favoriteMoviesLabel.text = movieListLabel
        }
    }

    func loadUserData(){
        // later getting the data from datamanager
        self.userData = DataManager.instance.currentUser
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
        let favoriteMovies = userData.movieList?.filter {$0.isLiked}
        return favoriteMovies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: SimpleMovieCell? = favoriteMoviesTableView.dequeueReusableCell(withIdentifier: movieCellId) as! SimpleMovieCell

        let favoriteMovies = userData.movieList?.filter {$0.isLiked}
        let movie: Movie = (favoriteMovies?[indexPath.row].movie)!

        let imageURL = URL(string: movie.imageURL.isEmpty ? "https://" : movie.imageURL)!

        cell?.movieImageView.af.setImage(withURL: imageURL, placeholderImage: #imageLiteral(resourceName: "default_movie_icon")) //add default image
                
        cell?.movieNameLabel.text = movie.title
        return cell!
    }


}

