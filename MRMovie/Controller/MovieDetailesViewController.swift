//
//  MovieDetailesViewController.swift
//  MRMovie
//
//  Created by User on 5/20/24.
//

import UIKit

class MovieDetailesViewController: UIViewController {
    
    @IBOutlet weak var movieDetailsTableView: UITableView!
    
    let viewModel = MovieDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        MoviesVC.delegate = self
        
        movieDetailsTableView.dataSource = self
        movieDetailsTableView.delegate = self
                
        movieDetailsTableView.register(MoviePosterTableViewCell.nib(), forCellReuseIdentifier: MoviePosterTableViewCell.identifier)
        movieDetailsTableView.register(MovieInformationTableViewCell.nib(), forCellReuseIdentifier: MovieInformationTableViewCell.identifier)

    }
}

extension MovieDetailesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.getSectionsCount()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.sectionTitles[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = movieDetailsTableView.dequeueReusableCell(withIdentifier: MoviePosterTableViewCell.identifier, for: indexPath) as? MoviePosterTableViewCell else {
                return UITableViewCell()
            }
            cell.configureMoviePosterTableViewCell(with: viewModel.movie?.image?.originalURL)
            return cell
        } else {
            guard let cell = movieDetailsTableView.dequeueReusableCell(withIdentifier: MovieInformationTableViewCell.identifier, for: indexPath) as? MovieInformationTableViewCell else {
                return UITableViewCell()
            }
            let detail = viewModel.detailForIndexPath(indexPath: indexPath)
            if let imageName = detail.imageName, let sectionInfo = detail.sectionInfo {
                cell.configureMovieInformationTableViewCell(with: imageName, sectionInfo: sectionInfo)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 300 : 50
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        header.textLabel?.frame = CGRect(x: Int(header.bounds.origin.x), y: Int(header.bounds.origin.y), width: 100, height: Int(header.bounds.height))
        header.textLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        header.textLabel?.text =  header.textLabel?.text?.uppercased()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        25
    }
}

extension MovieDetailesViewController: MovieSelectionDelegate {
    func movieSelected(_ movie: Movie) {
        self.title = movie.name
        viewModel.movie = movie
        self.movieDetailsTableView.reloadData()
    }
}

