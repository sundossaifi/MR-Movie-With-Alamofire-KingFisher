//
//  MovieDetailViewModel.swift
//  MRMovie
//
//  Created by User on 5/26/24.
//

import Foundation

class MovieDetailViewModel {
    var movie: Movie?
    let sectionTitles: [String] = ["Cover Photo", "Name", "Type", "Score", "Genres", "Status", "Schedule"]
    let imageNames: [String] = ["Name", "Type", "Score", "Genres", "Status", "clock", "calender"]

    func getSectionsCount() -> Int {
        return sectionTitles.count
    }

    func numberOfRows(in section: Int) -> Int {
        return sectionTitles[section] == "Schedule" ? 2 : 1
    }

    func detailForIndexPath(indexPath: IndexPath) -> (imageName: String?, sectionInfo: String?) {
        guard let movie = movie else { return (nil, nil) }

        switch indexPath.section {
        case 1:
            return ("Name", movie.name)
        case 2:
            return ("Type", movie.type)
        case 3:
            return ("Score", movie.rating?.average.map { String($0) })
        case 4:
            return ("Genres", movie.genres.joined(separator: ", "))
        case 5:
            return ("Status", movie.status)
        case 6:
            if indexPath.row == 0 {
                return ("clock", "\(movie.schedule?.time ?? "N/A")")
            } else {
                return ("calender", "\(movie.schedule?.days?.joined(separator: ", ") ?? "N/A")")
            }
        default:
            return (nil, nil)
        }
    }
}
