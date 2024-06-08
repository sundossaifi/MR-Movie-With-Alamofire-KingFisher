//
//  MovieInformationCellModel.swift
//  MRMovie
//
//  Created by User on 6/8/24.
//

import Foundation

class MovieInformationCellModel: MovieDetailsCellModel {
    let imageName: String?
    let detail: String?

    init(imageName: String?, detail: String?) {
        self.imageName = imageName
        self.detail = detail
    }
}
