//
//  ShowEpisodeViewController.swift
//  unit-three-project-two
//
//  Created by Levi Davis on 9/10/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import UIKit

class ShowEpisodeViewController: UIViewController {
    
    var oneShow: Show!
    var 

    @IBOutlet weak var episodeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        episodeTableView.delegate = self
        episodeTableView.dataSource = self

        // Do any additional setup after loading the view.
    }

}

extension ShowEpisodeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = episodeTableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as? ShowTableViewCell {
            cell.episodeNameLabel.text = oneShow.show.name
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    
}
