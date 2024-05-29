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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        starsRatingImageViews.forEach { $0.image = UIImage(systemName: "star") }
        moviePosterImageView.image = nil
        noPhotoLabel.isHidden = false
    }
    
    private func configureMoviePosterImageView() {
        self.moviePosterImageView.layer.cornerRadius = 8
    }
    
    private func updateStarRating(rating: Double) {
        let fullStars = Int(rating)
        let halfStarThreshold = (rating - Double(fullStars)) >= 0.5
        
        for (index, imageView) in starsRatingImageViews.enumerated() {
            if index < fullStars {
                imageView.image = UIImage(systemName: "star.fill")
            } else if index == fullStars && halfStarThreshold {
                imageView.image = UIImage(systemName: "star.leadinghalf.filled")
            } else {
                imageView.image = UIImage(systemName: "star")
            }
        }
    }
    
    func configureCell(movie: Movie) {
        movieNameLabel.text = movie.name
        movieTypeLabel.text = movie.type
        if let originalURL = movie.image?.originalURL {
            moviePosterImageView.kf.setImage(with: originalURL)
            noPhotoLabel.isHidden = true
        } else {
            moviePosterImageView.image = nil
            noPhotoLabel.isHidden = false
        }
        guard let average = movie.rating?.average else {
            return
        }
        updateStarRating(rating: average / 2)
    }
}
