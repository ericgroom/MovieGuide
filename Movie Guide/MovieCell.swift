//
//  MovieCell.swift
//  Movie Guide
//
//  Created by Eric Groom on 10/25/16.
//  Copyright © 2016 Eric Groom. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCell: UITableViewCell {
    

    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        super.setSelected(false, animated: true)
        // Configure the view for the selected state
    }
    
    var movie : Movie! {
        didSet {
            titleLabel.text = movie.movieTitle
            if(movie?.moviePosterUrl != nil) {
                posterImage.af_setImage(withURL: URL(string: movie.moviePosterUrl!)!)
            }
        }
    }


}
