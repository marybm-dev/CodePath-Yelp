//
//  DetailViewController.swift
//  Yelp
//
//  Created by Mary Martinez on 10/24/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var reviewsCountLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    
    var business: Business!
    var reviews = [Review]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        thumbImageView.setImageWith(business.imageURL!)
        nameLabel.text = business.title!
        ratingImageView.setImageWith(business.ratingImageURL!)
        addressLabel.text = business.address!
        categoriesLabel.text = business.categories!
        reviewsCountLabel.text = "\(business.reviewCount!) Reviews"
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        getReviews()
    }
    
    func getReviews() {
        Business.businessReviews(business.id!, completion: {
            (reviews: [Review]?, error: Error?) -> Void in
            
            if let businessReviews = reviews {
                self.reviews = businessReviews
                self.tableView.reloadData()
            }
            
            print(reviews)
            print(reviews?.count)
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.reviews.count > 0 {
            return self.reviews.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewCell
        
        cell.review = reviews[indexPath.row]
        
        return cell
    }
}
