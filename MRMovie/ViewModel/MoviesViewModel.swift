//
//  MoviesViewModel.swift
//  MRMovie
//
//  Created by User on 5/24/24.
//

import UIKit

protocol MoviesViewModelDelegate: AnyObject {
    func onFetchCompleted(withNewData: Bool)
    func onFetchFailed(with reason: String)
}

class MoviesViewModel {
    weak var delegate: MoviesViewModelDelegate?
    var shows: [Show] = []
    var currentPage: Int = 0
    var isFetchInProgress = false

    init() {
        fetchMoviesIfNeeded()
    }

    func getMoviesCount() -> Int {
        return shows.count
    }

    func fetchMoviesIfNeeded() {
        guard !isFetchInProgress else { return }
        isFetchInProgress = true
        let nextPage = currentPage + 1

        MoviesAPICaller.shared.fetchMovies(nextPage) { [weak self] shows in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isFetchInProgress = false
                let newShows = shows

                if newShows.isEmpty {
                    self.delegate?.onFetchCompleted(withNewData: false)
                } else {
                    if nextPage == 1 {
                        self.shows = newShows
                    } else {
                        self.shows.append(contentsOf: newShows)
                    }
                    self.currentPage = nextPage
                    self.delegate?.onFetchCompleted(withNewData: true)
                }
            }
        } onFailure: { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isFetchInProgress = false
                self.delegate?.onFetchFailed(with: error.localizedDescription)
            }
        }
    }
}
