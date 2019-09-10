//
//  ShowViewController.swift
//  unit-three-project-two
//
//  Created by Levi Davis on 9/9/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {

    @IBOutlet weak var showSearchBar: UISearchBar!
    @IBOutlet weak var showTableView: UITableView!
    @IBOutlet weak var activitySpinnerOutlet: UIActivityIndicatorView!
    
    var shows = [Show]() {
        didSet {
            self.showTableView.reloadData()
        }
    }
    
    
    
    var searchString: String? = nil {
        didSet {
            self.showTableView.reloadData()
        }
    }
    
    var searchResults: [Show] {
        get {
            
            guard let searchString = searchString else {return shows}
            guard searchString != "" else {return shows}
            
            return shows
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ShowEpisodeViewController {
            guard let indexPath = showTableView.indexPathForSelectedRow,
            let episodeVC = segue.destination as? ShowEpisodeViewController else {return}
            let oneShow = shows[indexPath.row]
            episodeVC.oneShow = oneShow
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showTableView.delegate = self
        showTableView.dataSource = self
        showSearchBar.delegate = self
        activitySpinnerOutlet.isHidden = true
        
    }
    
}

extension ShowViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = showTableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as? ShowTableViewCell {
            let oneShow = searchResults[indexPath.row]
            
            if let urlString = oneShow.show.image?.original {

                ImageHelper.shared.fetchImage(urlString: urlString) { (result) in
                    DispatchQueue.main.async {
                        switch result {
                        case .failure(let error):
                            print(error)
                        case .success(let image):
                            self.activitySpinnerOutlet.stopAnimating()
                            cell.showImageView.image = image
                        }
                    }
                }
            }
            
            cell.showNameLabel.text = oneShow.show.name
            cell.showRatingLabel.text = "Rating: \(oneShow.show.rating?.average ?? 0)"
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchString = searchText.lowercased()
        activitySpinnerOutlet.startAnimating()
        
            Show.getShowData(searchString: searchString) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let shows):
                        self.shows = shows
                    }
                }
            }
        }
    
}
