//
//  MovieDetailsViewModel.swift
//  MRMovie
//
//  Created by User on 5/26/24.
//

import Foundation

enum Section: Int, CaseIterable {
    case coverPhoto, name, type, score, genres, status, schedule
    
    var headerTitle: String {
        switch self {
        case .coverPhoto: return "Cover Photo"
        case .name: return "Name"
        case .type: return "Type"
        case .score: return "Score"
        case .genres: return "Genres"
        case .status: return "Status"
        case .schedule: return "Schedule"
        }
    }
    
    var footerText: String? {
        switch self {
        case .coverPhoto: return "This photo should be a landscape to fit the cover"
        case .score: return "The number of points"
        case .genres: return "A category of artistic composition"
        case .schedule: return "Time and Date that movie will show"
        default: return nil
        }
    }
}

class MovieDetailsViewModel {
    var movie: Movie?
    var sections: [Section] = Section.allCases
    
    init(movie: Movie? = nil) {
        self.movie = movie
    }
    
    func numberOfRows(for sectionIndex: Int) -> Int {
        guard let section = Section(rawValue: sectionIndex) else { return 0 }
        return section == .schedule ? 2 : 1
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func detailForIndexPath(indexPath: IndexPath) -> (imageName: String?, sectionInfo: String?) {
        guard let section = Section(rawValue: indexPath.section), let movie = movie else { return (nil, nil) }
        
        switch section {
        case .name:
            return ("Name", movie.name)
        case .type:
            return ("Type", movie.type)
        case .score:
            return ("Score", movie.rating?.average.map { String($0) })
        case .genres:
            return ("Genres", movie.genres.joined(separator: ", "))
        case .status:
            return ("Status", movie.status)
        case .schedule:
            let info = indexPath.row == 0 ? movie.schedule?.time : movie.schedule?.days?.joined(separator: ", ")
            let imageName = indexPath.row == 0 ? "clock" : "calender"
            return (imageName, info)
        default:
            return (nil, nil)
        }
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 300 : 50
    }
    
    func heightForFooterInSection(section: Int) -> CGFloat {
        guard let section = Section(rawValue: section) else { return CGFloat.leastNormalMagnitude }
        return section.footerText != nil ? 30 : CGFloat.leastNormalMagnitude
    }
    
    func footerText(for sectionIndex: Int) -> String? {
        guard let section = Section(rawValue: sectionIndex) else { return nil }
        return section.footerText
    }
}
