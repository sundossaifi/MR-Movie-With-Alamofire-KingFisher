//
//  MoviePosterCellModel.swift
//  MRMovie
//
//  Created by User on 6/8/24.
//

import Foundation

class MoviePosterCellModel: MovieDetailsCellModel {
    let imageURL: URL

    init(imageURL: URL) {
        self.imageURL = imageURL
    }
}
