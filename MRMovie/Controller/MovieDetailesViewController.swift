//
//  MovieDetailesViewController.swift
//  MRMovie
//
//  Created by User on 5/20/24.
//

import UIKit

class MovieDetailesViewController: UIViewController {
    
    @IBOutlet weak var movieDetailsTableView: UITableView!
    
    var viewModel: MovieDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        movieDetailsTableView.dataSource = self
        movieDetailsTableView.delegate = self
        
        movieDetailsTableView.register(MoviePosterTableViewCell.nib(), forCellReuseIdentifier: MoviePosterTableViewCell.identifier)
        movieDetailsTableView.register(MovieInformationTableViewCell.nib(), forCellReuseIdentifier: MovieInformationTableViewCell.identifier)
        
        title = viewModel?.movie?.name
        
        navigationController?.navigationBar.tintColor = .label
        
    }
}

extension MovieDetailesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel?.sections[indexPath.section].rows[indexPath.row]
        
        if let posterModel = model as? MoviePosterCellModel {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviePosterTableViewCell.identifier, for: indexPath) as? MoviePosterTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: posterModel)
            return cell
        } else if let infoModel = model as? MovieInformationCellModel {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieInformationTableViewCell.identifier, for: indexPath) as? MovieInformationTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: infoModel)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel?.footerHeight(for: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerTitle = viewModel?.sections[section].headerTitle.uppercased() else { return nil }
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 50))
        let headerLabel = UILabel(frame: CGRect(x: 16, y: 0, width: tableView.bounds.width - 32, height: 60))
        headerLabel.text = headerTitle
        headerLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        headerLabel.textColor = .gray
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerText = viewModel?.sections[section].footerText else { return nil }
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 30))
        let footerLabel = UILabel(frame: CGRect(x: 16, y: 0, width: tableView.bounds.width - 32, height: 30))
        footerLabel.text = footerText
        footerLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        footerLabel.textColor = .gray
        footerView.addSubview(footerLabel)
        return footerView
    }
}


