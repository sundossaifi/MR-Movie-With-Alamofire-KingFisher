//
//  MovieDetailsViewModel.swift
//  MRMovie
//
//  Created by User on 5/26/24.
//

import Foundation

class MovieDetailsViewModel {
    var movie: Movie?
    var sections: [SectionModel]
    
    init(movie: Movie? = nil) {
        self.movie = movie
        self.sections = MovieDetailsViewModel.createSections(for: movie)
    }
    
    private static func createSections(for movie: Movie?) -> [SectionModel] {
        var sections = [SectionModel]()
        
        if let imageURL = movie?.image?.originalURL {
            let coverPhotoModel = MoviePosterCellModel(imageURL: imageURL)
            sections.append(SectionModel(type: .coverPhoto, footerText: "This photo should be a landscape to fit the cover", footerHeight: 30, rows: [coverPhotoModel]))
        }
   
        if let name = movie?.name {
            let nameModel = MovieInformationCellModel(imageName: "Name", detail: name)
            sections.append(SectionModel(type: .name, footerText: nil, footerHeight: CGFloat.leastNormalMagnitude, rows: [nameModel]))
        }
  
        if let type = movie?.type {
            let typeModel = MovieInformationCellModel(imageName: "Type", detail: type)
            sections.append(SectionModel(type: .type, footerText: nil, footerHeight: CGFloat.leastNormalMagnitude, rows: [typeModel]))
        }
        
        if let score = movie?.rating?.average.map({ String($0) })  {
            let scoreModel = MovieInformationCellModel(imageName: "Score", detail: score)
            sections.append(SectionModel(type: .score, footerText: "The number of points", footerHeight: 30, rows: [scoreModel]))
        }
        
        if let genres = movie?.genres.joined(separator: ", ") {
            let genresModel = MovieInformationCellModel(imageName: "Genres", detail: genres)
            sections.append(SectionModel(type: .genres, footerText: "A category of artistic composition", footerHeight: 30, rows: [genresModel]))
        }

        if let status = movie?.status {
            let statusModel = MovieInformationCellModel(imageName: "Status", detail: status)
            sections.append(SectionModel(type: .status, footerText: nil, footerHeight: CGFloat.leastNormalMagnitude, rows: [statusModel]))
        }

        if let time = movie?.schedule?.time, let days = movie?.schedule?.days?.joined(separator: ", ") {
            let timeModel = MovieInformationCellModel(imageName: "clock", detail: time)
            let daysModel = MovieInformationCellModel(imageName: "Calendar", detail: days)
            sections.append(SectionModel(type: .schedule, footerText: "Time and Date that movie will show", footerHeight: 30, rows: [timeModel, daysModel]))
        }
        
        return sections
    }
    
    func footerHeight(for sectionIndex: Int) -> CGFloat {
        return sections[sectionIndex].footerHeight
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        return sections[section].numberOfRows
    }
}
