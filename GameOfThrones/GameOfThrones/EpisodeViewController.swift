//
//  EpisodeViewController.swift
//  GameOfThrones
//
//  Created by Kelby Mittan on 11/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {

    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var airdateLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    var gotEpisode: GOTEpisode?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let episode = gotEpisode else {
            fatalError()
        }
        
        episodeImage.layer.cornerRadius = 10
        episodeImage.image = UIImage(named: episode.originalImageID)
        titleLabel.text = episode.name
        seasonLabel.text = "Season: \(episode.season)"
        episodeLabel.text = "Episode: \(episode.number)"
        runtimeLabel.text = "Runtime: \(episode.runtime)"
        airdateLabel.text = "Airdate: \(episode.airdate)"
        descriptionText.text = episode.summary
        
    }
    


}
