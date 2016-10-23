//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import KVNProgress

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FiltersViewControllerDelegate, UISearchBarDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var businesses = [Business]()
    var searchBar: UISearchBar!
    
    var isMoreDataLoading = false
    var searchActive = false
    var searchedBusinesses = [Business]()
    
    var logoButton: UIButton!
    var barButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup tableView
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120

        // setup searchBar
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        // setup yelp logo
        logoButton = UIButton(type: UIButtonType.custom)
        logoButton.setImage(UIImage(named: "yelpIcon"), for: .normal)
        logoButton.sizeToFit()
        barButtonItem = UIBarButtonItem(customView: logoButton)
        navigationItem.leftBarButtonItem = barButtonItem
        
        // fetchData
        fetchData()
        
    }

    // app logic
    func fetchData() {
        
        // display activity indicator
        KVNProgress.show()
        
        Business.searchWithTerm(term: "Restaurants", offset: businesses.count, completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses.append(contentsOf: businesses!)
            self.tableView.reloadData()
            self.isMoreDataLoading = false
            
            // hide activity indicator
            KVNProgress.dismiss()
        })
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if !isMoreDataLoading {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                isMoreDataLoading = true
                
                // ... Code to load more results ...
                self.fetchData()
            }
        }
    }
    
    // Mark: – TableViewControllerDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchActive {
            return searchedBusinesses.count
        }
        else if !searchActive {
            return businesses.count
        }

        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessCell", for: indexPath) as! BusinessCell
        
        if searchActive {
            cell.business = searchedBusinesses[indexPath.row]
        }
        else {
            cell.business = businesses[indexPath.row]
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        
        filtersViewController.delegate = self
    }
    
    // Mark: – FiltersViewControllerDelegate
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        
        // display activity indicator
        KVNProgress.show()
        
        let categories = filters["categories"] as? [String]
        let sort = filters["sort"] as? Int
        let deals = filters["deals"] as? Bool

        Business.searchWithTerm(term: "Restaurants", sort: sort.map { YelpSortMode(rawValue: $0) }!, categories: categories, deals: deals, offset: 0, completion: {
            (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses!
            self.tableView.reloadData()
            
            // hide activity indicator
            KVNProgress.dismiss()
        })
    }
    
    // Mark: – UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedBusinesses = businesses.filter({ (business) -> Bool in
            var temp = NSString()
            
            if let name = business.name {
                temp = name as NSString
                
            }
            let range = temp.range(of: searchText, options: .caseInsensitive)
            return range.location != NSNotFound
        })
        
        if searchedBusinesses.count == 0 {
            searchActive = false
        }
        else {
            searchActive = true
        }
        self.tableView.reloadData()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }

}
