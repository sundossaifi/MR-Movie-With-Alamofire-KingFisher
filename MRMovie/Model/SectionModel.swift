//
//  SectionModel.swift
//  MRMovie
//
//  Created by User on 6/3/24.
//

import Foundation

enum SectionType: String {
    case coverPhoto = "Cover Photo"
    case name = "Name"
    case type = "Type"
    case score = "Score"
    case genres = "Genres"
    case status = "Status"
    case schedule = "Schedule"
}

struct SectionModel {
    let type: SectionType
    let footerText: String?
    let footerHeight: CGFloat
    var rows: [MovieDetailsCellModel]
    
    
    var headerTitle: String {
        return type.rawValue
    }
    
    var numberOfRows: Int {
        return rows.count
    }
}
