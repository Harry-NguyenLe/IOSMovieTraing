//
//  MovieCellTableViewCell.swift
//  MovieTrainingApp
//
//  Created by Harry Nguyen on 27/01/2022.
//

import UIKit

protocol MovieTableViewCellDelegate: AnyObject {
    func watchMovieBtnClick(subcribeButtonTappedFor movieData: MovieData)
}

class MovieCell: UITableViewCell {

    @IBOutlet weak var moviePosterView: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var movieViewsNumberLabel: UILabel!
    
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    @IBOutlet weak var movieLikedButton: LikeButton!
    
    @IBOutlet weak var movieWatchingButton: UIButton!
    
    weak var delegate: MovieTableViewCellDelegate?
    
    var isLike = false
    
    var movieData: MovieData?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieLikedButton.setImage(UIImage(named: "ic_like@3x.png"), for: .normal)
        movieLikedButton.setTitle("  Like", for: .normal)
        self.movieWatchingButton.addTarget(self, action: #selector(setOnWatchMovieClickListener(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  
    @IBAction func setOnWatchMovieClickListener(_ sender: UIButton) {
        if delegate != nil && movieData != nil {
            self.delegate?.watchMovieBtnClick(subcribeButtonTappedFor: movieData!)
        }
    }
    
    @IBAction func setOnTouchListener(_ sender: LikeButton) {
        if isLike == true {
            isLike = false
            movieLikedButton.setImage(UIImage(named: "ic_like_orange@3x.png"), for: .normal)
            movieLikedButton.setTitle("  Liked", for: .normal)
        }else {
            isLike = true
            movieLikedButton.setImage(UIImage(named: "ic_like@3x.png"), for: .normal)
            movieLikedButton.setTitle("  Like", for: .normal)
        }
    }
}
