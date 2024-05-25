//
//  show.swift
//  MRMovie
//
//  Created by User on 5/24/24.
//

import Foundation

struct Show: Codable {
    let id: Int
    let url: String
    let name: String
    let type: String
    let language: String?
    let genres: [String]
    let status: String?
    let runtime: Int?
    let averageRuntime: Int?
    let premiered: String?
    let ended: String?
    let officialSite: String?
    let schedule: Schedule?
    let rating: Rating?
    let weight: Int?
    let network: Network?
    let webChannel: WebChannel?
    let dvdCountry: DVD?
    let externals: Externals
    let image: Image?
    let summary: String?
    let updated: Int?
    let links: Links?
    
    struct Schedule: Codable {
        let time: String?
        let days: [String]?
    }
    
    struct Rating: Codable {
        let average: Double?
    }
    
    struct Country: Codable {
        let name: String
        let code: String
        let timezone: String
    }
    
    struct Network: Codable {
        let id: Int
        let name: String
        let country: Country
        let officialSite: String?
    }
    
    struct WebChannel: Codable {
        let id: Int
        let name: String
        let country: Country?
        let officialSite: String?
    }
    
    struct DVD: Codable {
        // Define properties if necessary
    }
    
    struct Externals: Codable {
        let tvrage: Int?
        let thetvdb: Int?
        let imdb: String?
    }
    
    struct Image: Codable {
        let medium: String
        let original: String
        
        var originalURL: URL? {
            return URL(string: original)
        }
        
        var mediumURL: URL? {
            return URL(string: medium)
        }
    }
    
    struct Links: Codable {
        let selfLink: Link
        let previousepisode: Link?
        
        enum CodingKeys: String, CodingKey {
            case selfLink = "self"
            case previousepisode
        }
        
        struct Link: Codable {
            let href: String
        }
    }
}
