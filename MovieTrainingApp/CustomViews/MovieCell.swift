//
//  MovieCellTableViewCell.swift
//  MovieTrainingApp
//
//  Created by Harry Nguyen on 27/01/2022.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var moviePosterView: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var movieViewsNumberLabel: UILabel!
    
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    
    @IBOutlet weak var movieLikedButton: UIButton!
    
    @IBOutlet weak var movieWatchingButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
