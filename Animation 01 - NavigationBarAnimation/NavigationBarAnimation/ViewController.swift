//
//  ViewController.swift
//  NavigationBarAnimation
//
//  Created by Larry Natalicio on 4/15/16.
//  Copyright © 2016 Larry Natalicio. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    // MARK: - Types
    
    struct Constants {
        struct Images {
            static let one = "one"
            static let two = "two"
            static let three = "three"
            static let four = "four"
            static let five = "five"
            static let six = "six"
        }
    }
    
    // MARK: - Properties

    var entries = [
        Entry(title: "First Entry", image: UIImage(named: "one")!),
        Entry(title: "Exploring", image: UIImage(named: "two")!),
        Entry(title: "Traveling Abroad", image: UIImage(named: "three")!),
        Entry(title: "Scuba Diving", image: UIImage(named: "four")!),
        Entry(title: "Trip Together", image: UIImage(named: "five")!),
        Entry(title: "The Unknown", image: UIImage(named: "six")!)
    ]
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adds animation to navigation controller to hide bar on swipe.
        configureNavigationController()
        
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! EntryCell
        
        let entry = entries[indexPath.row]
        
        cell.entryTitle.text = entry.title
        cell.entryImage.image = entry.image
        
        return cell
    }
    
    // MARK: - Convenience
    
    func configureNavigationController() {
        navigationController?.hidesBarsOnSwipe = true
    }

}

