//
//  MoviesTableViewController.swift
//  MRMovie
//
//  Created by User on 5/20/24.
//

import UIKit

class MoviesTableViewController: UITableViewController {
  
    
    let viewModel = MoviesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        print(viewModel.shows.count)
        tableView.register(MoviesTableViewCell.nib(), forCellReuseIdentifier: MoviesTableViewCell.identifier)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getMoviesCount()
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier, for: indexPath) as? MoviesTableViewCell else {return UITableViewCell()}
        let show = viewModel.shows[indexPath.row]
        cell.configureCell(show: show)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let count = viewModel.getMoviesCount()
        if indexPath.item == count-1 {
            viewModel.fetchMoviesIfNeeded()
        }
    }
}

extension MoviesTableViewController: MoviesViewModelDelegate {
    func onFetchCompleted(withNewData: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func onFetchFailed(with reason: String) {
        
    }
}

