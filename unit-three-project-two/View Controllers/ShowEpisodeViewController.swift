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
    var episodes: [Episode]? {
        didSet {
            episodeTableView.reloadData()
        }
    }

    @IBOutlet weak var episodeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        episodeTableView.delegate = self
        episodeTableView.dataSource = self
        loadData()
        // Do any additional setup after loading the view.
    }

    func loadData() {
        Episode.getEpisodeData(showID: oneShow.show.id) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let episodes):
                    self.episodes = episodes
                }
            }
        }
    }
    
    
}

extension ShowEpisodeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = episodeTableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as? ShowTableViewCell {
            let oneEpisode = episodes?[indexPath.row]
            ImageHelper.shared.fetchImage(urlString: oneEpisode?.image.original ?? "") { (results) in
                DispatchQueue.main.async {
                    switch results {
                    case .failure(let error):
                        print(error)
                    case .success(let image):
                        cell.episodeImageView.image = image
                    }
                }
            }
            
            cell.episodeNameLabel.text = oneEpisode?.name
            cell.epsiodeSeasonAndNumberLabel.text = "S: \(oneEpisode?.season ?? 0) E: \(oneEpisode?.number ?? 0)"
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}
