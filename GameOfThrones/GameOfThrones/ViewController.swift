//
//  ViewController.swift
//  GameOfThrones
//
//  Created by Alex Paul on 11/16/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gotTableView: UITableView!
    
    
    private var episodes = [[GOTEpisode]]() {
        didSet {
            gotTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gotTableView.dataSource = self
        loadData()
        
        gotTableView.dequeueReusableCell(withIdentifier: "gotCell")?.textLabel?.textAlignment = .center
        gotTableView.dequeueReusableCell(withIdentifier: "gotCell")?.detailTextLabel?.textAlignment = .center
    }
    
    func loadData() {
        episodes = GOTEpisode.getSections()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let episodeVC = segue.destination as? EpisodeViewController, let indexPath = gotTableView.indexPathForSelectedRow else {
            return
        }
        
        episodeVC.episode = episodes[indexPath.section][indexPath.row]
    }
    
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return episodes[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let episode = episodes[indexPath.section][indexPath.row]

        if episode.season % 2 == 0 {
            guard let cellOne = gotTableView.dequeueReusableCell(withIdentifier: "gotCellTwo", for: indexPath) as? EpisodeRightCell else {
            fatalError()
            }
            cellOne.configureCell(for: episode)
            return cellOne
        } else {
            guard let cellTwo = gotTableView.dequeueReusableCell(withIdentifier: "gotCell", for: indexPath) as? EpisodeCellTableViewCell else {
            fatalError()
            }
            cellTwo.configureCell(for: episode)
            return cellTwo
        }
        
//        let cell = gotTableView.dequeueReusableCell(withIdentifier: "gotCell", for: indexPath)
//        let episode = episodes[indexPath.section][indexPath.row]
//
//        cell.textLabel?.text = episode.name
//        cell.detailTextLabel?.text = "S:\(episode.season)" + " E:\(episode.number)"
//
//        cell.imageView?.image = UIImage(named: episode.mediumImageID)
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let seasonString = "Season \(String(episodes[section].first?.season ?? 0))"
        return seasonString
    }
}

