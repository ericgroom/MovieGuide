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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var movies: [Movie]! = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        super.setSelected(false, animated: true)
        // Configure the view for the selected state
    }
    

}

extension MovieCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell : MovieCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! MovieCollectionViewCell
            cell.posterImage.af_setImage(withURL: URL(string: (movies![indexPath.row].moviePosterUrl!))!)
        return cell
        }
    
    }


extension MovieCell : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 3
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}
