//
//  MoviePosterTableViewCell.swift
//  MRMovie
//
//  Created by User on 5/26/24.
//

import UIKit
import Kingfisher

class MoviePosterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureMoviePosterTableViewCell(with imageURL: URL?) {
        moviePosterImageView.kf.setImage(with: imageURL)
    }
}
