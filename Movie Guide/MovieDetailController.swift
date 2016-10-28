//
//  MovieDetailController.swift
//  Movie Guide
//
//  Created by Eric Groom on 10/28/16.
//  Copyright © 2016 Eric Groom. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailController: UIViewController {

    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = movie?.movieTitle
        self.overviewLabel.text = movie?.movieOverview
        
        if(movie?.movieBackdropPathUrl != nil) {
            backdropImage.af_setImage(withURL: URL(string: movie!.movieBackdropPathUrl!)!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
