//
//  MoviesTableViewCell.swift
//  MRMovie
//
//  Created by User on 5/20/24.
//

import UIKit
import Kingfisher

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieTypeLabel: UILabel!
    @IBOutlet var starsRatingImageViews: [UIImageView]!
    @IBOutlet weak var noPhotoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureMoviePosterImageView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configureMoviePosterImageView()
    }
    
    private func configureMoviePosterImageView() {
        self.moviePosterImageView.layer.cornerRadius = 8
    }
    
    func configureCell(show: Show) {
        movieNameLabel.text = show.name
        movieTypeLabel.text = show.type
        if let urlString = show.image?.original, let url = URL(string: urlString) {
            moviePosterImageView.kf.setImage(with: url)
            noPhotoLabel.isHidden = true
        } else {
            moviePosterImageView.image = nil 
            noPhotoLabel.isHidden = false
        }
    }
}
