//
//  DetailViewController.swift
//  Yelp
//
//  Created by Mary Martinez on 10/24/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var reviewsCountLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    
    var business: Business!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        thumbImageView.setImageWith(business.imageURL!)
        nameLabel.text = business.title!
        ratingImageView.setImageWith(business.ratingImageURL!)
        addressLabel.text = business.address!
        categoriesLabel.text = business.categories!
        reviewsCountLabel.text = "\(business.reviewCount!) Reviews"
        
        getReviews()
    }
    
    func getReviews() {
        Business.businessReviews(business.id!, completion: {
            (reviews: [Review]?, error: Error?) -> Void in
            
            self.business.reviews = reviews
            
            print(reviews)
        })
    }
}
