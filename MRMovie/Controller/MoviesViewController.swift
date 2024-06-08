//
//  MoviesViewController.swift
//  MRMovie
//
//  Created by User on 5/24/24.
//

import UIKit

class MoviesViewController: UIViewController {
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var searchMovieBar: UISearchBar!
    @IBOutlet weak var loadingMoviesIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    let viewModel = MoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel.fetchMoviesIfNeeded()
    }
    
    private func configureView() {
        self.viewModel.delegate = self
        
        self.moviesTableView.dataSource = self
        self.moviesTableView.delegate = self
        self.moviesTableView.register(MoviesTableViewCell.nib(), forCellReuseIdentifier: MoviesTableViewCell.identifier)
        
        self.searchMovieBar.delegate = self
        
        navigationController?.navigationBar.tintColor = .label
    }
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getFilteredMoviesCount()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier, for: indexPath) as? MoviesTableViewCell else {return UITableViewCell()}
        let movie = viewModel.filteredMovies[indexPath.row]
        cell.configureCell(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let count = viewModel.getMoviesCount()
        if indexPath.item == count-1 {
            viewModel.fetchMoviesIfNeeded()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let movieDetailsVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailesViewController") as? MovieDetailesViewController {
            let viewModel = MovieDetailsViewModel(movie: viewModel.filteredMovies[indexPath.row])
            movieDetailsVC.viewModel = viewModel
            let detailNavigationController = UINavigationController(rootViewController: movieDetailsVC)
            self.splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
    }
}

extension MoviesViewController: MoviesViewModelDelegate {
    func onFetchStarted() {
        DispatchQueue.main.async {
            self.loadingMoviesIndicator.isHidden = false
            self.loadingMoviesIndicator.startAnimating()
        }
    }
    
    func onFetchCompleted() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.loadingMoviesIndicator.isHidden = true
            self.loadingMoviesIndicator.stopAnimating()
            self.noDataLabel.isHidden = true
            self.moviesTableView.reloadData()
        }
    }
    
    func onFetchFailed(with reason: String) {
        DispatchQueue.main.async {
            self.loadingMoviesIndicator.stopAnimating()
            self.noDataLabel.isHidden = false
            self.noDataLabel.text = "Failed to fetch data: \(reason)"
        }
    }
    
    func onNoData() {
        DispatchQueue.main.async {
            self.loadingMoviesIndicator.stopAnimating()
            self.noDataLabel.isHidden = false
            self.noDataLabel.text = "No results found."
            self.moviesTableView.reloadData()
        }
    }
}

extension MoviesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterMovies(for: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        viewModel.filterMovies(for: "")
    }
}

