//
//  EpisodeRightCell.swift
//  GameOfThrones
//
//  Created by Kelby Mittan on 11/18/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class EpisodeRightCell: UITableViewCell {

    @IBOutlet weak var gotImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
    }
    
    
    func configureCell(for episode: GOTEpisode) {
        gotImage.image = UIImage(named: episode.mediumImageID)
        titleLabel?.text = episode.name
        episodeLabel?.text = "S:\(episode.season) E:\(episode.number)"
    }

}
