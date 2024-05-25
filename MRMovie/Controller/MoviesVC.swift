//
//  MoviesVC.swift
//  MRMovie
//
//  Created by User on 5/24/24.
//

import UIKit
import Toast

class MoviesVC: UIViewController {
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var searchMovieBar: UISearchBar!
    @IBOutlet weak var loadingMoviesIndicator: UIActivityIndicatorView!
    
    let viewModel = MoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        self.viewModel.delegate = self
        self.moviesTableView.dataSource = self
        self.moviesTableView.delegate = self
        self.moviesTableView.register(MoviesTableViewCell.nib(), forCellReuseIdentifier: MoviesTableViewCell.identifier)
        self.searchMovieBar.delegate = self
    }
}

extension MoviesVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredShows.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier, for: indexPath) as? MoviesTableViewCell else {return UITableViewCell()}
        let show = viewModel.filteredShows[indexPath.row]
        cell.configureCell(show: show)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let count = viewModel.getMoviesCount()
        if indexPath.item == count-1 {
            viewModel.fetchMoviesIfNeeded()
        }
    }
}

extension MoviesVC: MoviesViewModelDelegate {
    func onFetchCompleted() {
        DispatchQueue.main.async {
            self.loadingMoviesIndicator.isHidden = false
            self.loadingMoviesIndicator.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.loadingMoviesIndicator.isHidden = true
                self.moviesTableView.reloadData()
            }
        }
    }
    
    func onFetchFailed(with reason: String) {
        print(reason)
        DispatchQueue.main.async {
            self.loadingMoviesIndicator.stopAnimating()
            self.loadingMoviesIndicator.isHidden = true
        }
    }
}

extension MoviesVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterShows(for: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        viewModel.filterShows(for: "")
    }
}

