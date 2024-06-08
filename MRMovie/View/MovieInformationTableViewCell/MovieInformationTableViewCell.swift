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
    
    func configure(with model: MovieInformationCellModel) {
        sectionInfoLabel.text = model.detail
        if let imageName = model.imageName {
            sectionIconImageView.image = UIImage(named: imageName)
        }
    }
}
