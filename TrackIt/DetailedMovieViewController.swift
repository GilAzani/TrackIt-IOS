//
//  DetailedMovieViewController.swift
//  TrackIt
//
//  Created by Student11 on 20/08/2024.
//

import UIKit
import AlamofireImage

class DetailedMovieViewController: UIViewController {
    var movie: Movie!
    var isAdded: Bool = false
    let notaddedImageName = "plus.circle"
    let notAddedString = "Add Movie To Your List"
    let addedImageString = "Movie In Your List"
    let addedImageName = "checkmark.circle"
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var movieStatusLabel: UILabel!
    @IBOutlet weak var addMovieImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        setUpUi()
    }
    func setUpUi(){
        movieTitleLabel.text = movie.title
        let imageURL = URL(string: movie.imageURL)!
        moviePosterImageView.af.setImage(withURL: imageURL, placeholderImage: #imageLiteral(resourceName: "default_movie_icon"))
        
        updateImage()
        
        descriptionLabel.text = movie.overview
        releaseYearLabel.text = movie.getReleaseYear()
        durationLabel.text = movie.getPrettyTimeString()
    }
    @IBAction func addOrRemoveMovieClicked(_ sender: UITapGestureRecognizer) {
        isAdded.toggle()
        updateImage()
        
        // TODO here update movies list accordinally
    }
    
    func updateImage(){
        let imageName = isAdded ? addedImageName : notaddedImageName
        let movieStatusString = isAdded ? addedImageString : notAddedString
        
        addMovieImageView.image = UIImage(systemName: imageName)
        movieStatusLabel.text = movieStatusString
    }
    
}
