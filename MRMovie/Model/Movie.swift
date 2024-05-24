//
//  Movie.swift
//  MRMovie
//
//  Created by User on 5/22/24.
//

import Foundation

struct Root: Codable {
    let score: Double
    let show: Show
}

struct Show: Codable {
    let id: Int
    let url: String
    let name: String
    let type: String
    let language: String
    let genres: [String]
    let status: String
    let runtime: Int?
    let averageRuntime: Int?
    let premiered: String
    let ended: String?
    let officialSite: String?
    let schedule: Schedule
    let rating: Rating
    let weight: Int
    let network: Network?
    let webChannel: WebChannel?
    let dvdCountry: String?
    let externals: Externals
    let image: Image?
    let summary: String
    let updated: Int
    let links: Links? // Make this optional
}

struct Schedule: Codable {
    let time: String
    let days: [String]
}

struct Rating: Codable {
    let average: Double?
}

struct Network: Codable {
    let id: Int
    let name: String
    let country: Country
}

struct Country: Codable {
    let name: String
    let code: String
    let timezone: String
}

struct WebChannel: Codable {
    let id: Int
    let name: String
    let country: Country?
}

struct Externals: Codable {
    let tvrage: Int?
    let thetvdb: Int?
    let imdb: String?
}

struct Image: Codable {
    let medium: String
    let original: String
}

struct Links: Codable {
    let selfLink: Link
    let previousepisode: Link?
    let nextepisode: Link?

    enum CodingKeys: String, CodingKey {
        case selfLink = "self"
        case previousepisode, nextepisode
    }
}

struct Link: Codable {
    let href: String
    let name: String?
}

