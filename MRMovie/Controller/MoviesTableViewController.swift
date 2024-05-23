//
//  MoviesTableViewController.swift
//  MRMovie
//
//  Created by User on 5/20/24.
//

import UIKit

class MoviesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MoviesTableViewCell.nib(), forCellReuseIdentifier: MoviesTableViewCell.identifier)
        if(NetworkMonitor.shared.isConnected) {
            print("connected")
        }
        else {
            print("not connected")
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier, for: indexPath) as? MoviesTableViewCell else {return UITableViewCell()}
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

  /*

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

