//
//  MovieInformationTableViewCell.swift
//  MRMovie
//
//  Created by User on 5/26/24.
//

import UIKit

class MovieInformationTableViewCell: UITableViewCell {

    @IBOutlet weak var sectionIconImageView: UIImageView!
    @IBOutlet weak var sectionInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        sectionIconImageView.image = nil
        sectionInfoLabel.text = nil
    }
    
    func configureMovieInformationTableViewCell(with imageName: String, sectionInfo: String?) {
        sectionInfoLabel.text = sectionInfo
        sectionIconImageView.image = UIImage(named: imageName)
    }
}
