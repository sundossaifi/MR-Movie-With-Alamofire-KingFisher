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
    func onNoData()
    func onFetchStarted()
}

class MoviesViewModel {
    weak var delegate: MoviesViewModelDelegate?
    var movies: [Movie] = []
    var filteredMovies: [Movie] = []
    var currentPage: Int = 0
    var isFetchInProgress = false
    
    init() {
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
        DispatchQueue.main.async {
            self.delegate?.onFetchStarted()
        }
        let nextPage = currentPage + 1
        
        MoviesAPICaller.shared.fetchMovies(nextPage) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isFetchInProgress = false
                self.handleFetchResult(result: result, nextPage: nextPage)
            }
        }
    }
    
    func handleFetchResult(result: Result<[Movie], Error>, nextPage: Int) {
        switch result {
        case .success(let movies):
            let newMovies = movies
            if newMovies.isEmpty {
                self.delegate?.onFetchCompleted()
            } else {
                self.movies.append(contentsOf: newMovies)
                self.filteredMovies = self.movies
                self.currentPage = nextPage
                self.delegate?.onFetchCompleted()
            }
        case .failure(let error):
            self.delegate?.onFetchFailed(with: error.localizedDescription)
        }
    }
    
    func filterMovies(for searchText: String) {
        if searchText.isEmpty {
            filteredMovies = movies
        } else {
            filteredMovies = movies.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        
        if filteredMovies.isEmpty {
            delegate?.onNoData()
        } else {
            delegate?.onFetchCompleted()
        }
    }
}
