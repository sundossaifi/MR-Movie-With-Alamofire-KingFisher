//
//  MovieDetailViewModel.swift
//  MRMovie
//
//  Created by User on 5/26/24.
//

import Foundation

class MovieDetailViewModel {
    var movie: Movie?
    let sectionTitles: [String] = ["Cover Photo", "Name", "Type", "Score","Genres","Status","Schedule"]
    let imageNames: [String] = ["Name","Type","Score","Genres","Status","clock","calender"]
    
    func getSectionsCount() -> Int {
        return sectionTitles.count
    }
}
