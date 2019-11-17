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
    }
    
    func loadData() {
        episodes = GOTEpisode.getSections()
    }
    
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return episodes[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = gotTableView.dequeueReusableCell(withIdentifier: "gotCell", for: indexPath)
        let episode = episodes[indexPath.section][indexPath.row]
        
        return cell
    }
}

