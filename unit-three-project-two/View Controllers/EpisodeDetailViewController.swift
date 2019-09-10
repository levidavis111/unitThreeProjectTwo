//
//  EpisodeDetailViewController.swift
//  unit-three-project-two
//
//  Created by Levi Davis on 9/10/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    
    var oneEpsiode: Episode!
    
    
    @IBOutlet weak var episodeDetailImageView: UIImageView!
    @IBOutlet weak var episodeDetailNameLabel: UILabel!
    @IBOutlet weak var episodeDetailSeasonAndNumberLabel: UILabel!
    @IBOutlet weak var episodeDetailSummaryTextView: UITextView!
    @IBOutlet weak var activitySpinnerOutlet: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activitySpinnerOutlet.startAnimating()
        setupViews()
    }
    
    private func setupViews() {
        getImage()
        episodeDetailNameLabel.text = oneEpsiode.name
        episodeDetailSeasonAndNumberLabel.text = "S: \(oneEpsiode.season ?? 0) E: \(oneEpsiode.number ?? 0)"
        episodeDetailSummaryTextView.text = oneEpsiode.summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }

    private func getImage() {
        guard let imageUrl = oneEpsiode.image?.original else {return}
        ImageHelper.shared.fetchImage(urlString: imageUrl) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    self.activitySpinnerOutlet.stopAnimating()
                    self.episodeDetailImageView.image = image
                }
            }
        }
    }
}
