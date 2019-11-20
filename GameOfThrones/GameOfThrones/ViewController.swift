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
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var episodes = [[GOTEpisode]]() {
        didSet {
            gotTableView.reloadData()
        }
    }
    
    var searchInput = ""  {
        didSet {
            episodes = GOTEpisode.getSections(episodeArrUpdate)
        }
    }
    
    var episodeArrUpdate: [GOTEpisode] {
        return GOTEpisode.allEpisodes.filter { $0.name.lowercased().contains(searchInput) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        gotTableView.dataSource = self
        loadData()
        
    }
    
    func loadData() {
        episodes = GOTEpisode.getSections(GOTEpisode.allEpisodes)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let episodeVC = segue.destination as? EpisodeViewController, let indexPath = gotTableView.indexPathForSelectedRow else {
            return
        }
        
        episodeVC.gotEpisode = episodes[indexPath.section][indexPath.row]
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
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let seasonString = "Season \(String(episodes[section].first?.season ?? 0))"
        return seasonString
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        loadData()
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let  char = searchText.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if !searchText.isEmpty {
            if isBackSpace == -92 {
                searchInput.removeLast()
            }
        }
        searchInput = searchText.lowercased()
        
        if searchText.isEmpty {
            loadData()
        }

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchText = searchBar.text {
            searchInput = searchText.lowercased()
            
            if searchText.isEmpty {
                loadData()
            }
            searchBar.text = ""
        }

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchInput = ""
        loadData()
    }
}

