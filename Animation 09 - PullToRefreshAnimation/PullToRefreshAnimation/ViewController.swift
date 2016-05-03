//
//  ViewController.swift
//  PullToRefreshAnimation
//
//  Created by Larry Natalicio on 4/25/16.
//  Copyright © 2016 Larry Natalicio. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, PullRefreshViewDelegate {
    
    // MARK: - Types
    
    struct Constants {
        struct ColorPalette {
            static let pruple = UIColor(red:0.31, green:0.20, blue:0.49, alpha:1.0)
            static let backgroundColor = UIColor(red: 43/255, green: 35/255, blue: 77/255, alpha: 1)
        }
    }

    // MARK: - Properties
    
    var pullRefreshView: PullRefreshView!
    let kPullRefreshViewHeight: CGFloat = UIScreen.mainScreen().bounds.size.height * 0.22
    let items = ["Avatar", "Star Wars", "Interstellar", "Predator", "The Martian", "They Live", "Contact", "Alien", "Independence Day", "Signs", "District 9", "Superman Returns"]
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        
        configureNavBar()
        configureTableView()
        
        // Part of pull-to-refresh animation.
        configureRefreshRect()
    }
    
    // MARK: - UIScrollViewDelegate
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        pullRefreshView.scrollViewDidScroll(scrollView)
    }
    
    override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        pullRefreshView.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = items[indexPath.row]
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - Convenience
    
    func PullRefreshViewDidRefresh(pullRefreshView: PullRefreshView) {
        delay(seconds: 2.5) {
            pullRefreshView.endRefreshing()
        }
    }
    
    func configureRefreshRect() {
        let refreshRect = CGRect(x: 0.0, y: -kPullRefreshViewHeight, width: view.frame.size.width, height: kPullRefreshViewHeight)
        pullRefreshView = PullRefreshView(frame: refreshRect, scrollView: self.tableView)
        pullRefreshView.delegate = self
        view.addSubview(pullRefreshView)
    }
    
    func configureNavBar() {
        self.navigationController?.navigationBar.barTintColor = Constants.ColorPalette.pruple
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
    }
    
    func configureTableView() {
        self.view.backgroundColor = Constants.ColorPalette.backgroundColor
    }
}

