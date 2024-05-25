//
//  MoviesAPICaller.swift
//  MRMovie
//
//  Created by User on 5/24/24.
//

import Foundation
import Alamofire

enum Constants {
    static let baseURL = "https://api.tvmaze.com/shows"
}

enum API {
    case fetchMovies(page: Int)
    
    var urlString: String {
        switch self {
        case .fetchMovies(let page):
            return "\(Constants.baseURL)?page=\(page)"
        }
    }
    
    var url: URL? {
        return URL(string: urlString)
    }
}
class MoviesAPICaller {
    static let shared = MoviesAPICaller()
    
    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        let responseCacher = ResponseCacher(behavior: .modify { _, response in
            let userInfo = ["date": Date()]
            return CachedURLResponse(
                response: response.response,
                data: response.data,
                userInfo: userInfo,
                storagePolicy: .allowed)
        })
        return Session(configuration: configuration,cachedResponseHandler: responseCacher)
    }()
    
    public func fetchMovies(_ page: Int, onSuccess: @escaping ([Movie]) -> Void, onFailure: @escaping (Error) -> Void) {
        guard let url = API.fetchMovies(page: page).url else {
            onFailure(NSError(domain: "APICaller", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        sessionManager.request(url).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {
                    onFailure(NSError(domain: "APICaller", code: -2, userInfo: [NSLocalizedDescriptionKey: "No data returned from API"]))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let results = try decoder.decode([Movie].self, from: data)
                    onSuccess(results)
                } catch {
                    onFailure(error)
                }
            case .failure(let error):
                onFailure(error)
            }
        }
    }
}
