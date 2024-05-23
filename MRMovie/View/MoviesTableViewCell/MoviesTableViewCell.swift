//
//  MoviesTableViewCell.swift
//  MRMovie
//
//  Created by User on 5/20/24.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieTypeLabel: UILabel!
    @IBOutlet var starsRatingImageViews: [UIImageView]!
    
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
}
