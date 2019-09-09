//
//  ShowViewController.swift
//  unit-three-project-two
//
//  Created by Levi Davis on 9/9/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {
    
    var shows = [Show]() {
        didSet {
            showTableView.reloadData()
        }
    }

    @IBOutlet weak var showSearchBar: UISearchBar!
    @IBOutlet weak var showTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showTableView.delegate = self
        showTableView.dataSource = self
        loadData()

        // Do any additional setup after loading the view.
    }
    

    private func loadData() {
        Show.getShowData { (result) in
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

extension ShowViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = showTableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as? ShowTableViewCell {
            let oneShow = shows[indexPath.row]
            cell.showNameLabel.text = oneShow.show.name
            return cell
        }
        
        
        
        return UITableViewCell()
    }
    
    
}
