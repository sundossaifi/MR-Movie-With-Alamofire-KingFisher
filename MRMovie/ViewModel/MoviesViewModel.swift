//
//  MoviesViewModel.swift
//  MRMovie
//
//  Created by User on 5/24/24.
//

import UIKit

protocol MoviesViewModelDelegate: AnyObject {
    func onFetchCompleted()
    func onFetchFailed(with reason: String)
}

class MoviesViewModel {
    weak var delegate: MoviesViewModelDelegate?
    var movies: [Movie] = []
    var filteredMovies: [Movie] = []
    var currentPage: Int = 0
    var isFetchInProgress = false

    init() {
        fetchMoviesIfNeeded()
    }

    func getMoviesCount() -> Int {
        return movies.count
    }
    
    func getFilteredMoviesCount() -> Int {
        return filteredMovies.count
    }

    func fetchMoviesIfNeeded() {
        guard !isFetchInProgress else { return }
        isFetchInProgress = true
        let nextPage = currentPage + 1

        MoviesAPICaller.shared.fetchMovies(nextPage) { [weak self] Movies in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isFetchInProgress = false
                let newMovies = Movies

                if newMovies.isEmpty {
                    self.delegate?.onFetchCompleted()
                } else {
                    if nextPage == 1 {
                        self.movies = newMovies
                    } else {
                        self.movies.append(contentsOf: newMovies)
                    }
                    self.filteredMovies = self.movies
                    self.currentPage = nextPage
                    self.delegate?.onFetchCompleted()
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
    
    func filterMovies(for searchText: String) {
        if searchText.isEmpty {
            filteredMovies = movies
        } else {
            filteredMovies = movies.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        delegate?.onFetchCompleted()
    }
}
