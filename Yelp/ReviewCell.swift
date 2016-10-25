//
//  ReviewCell.swift
//  Yelp
//
//  Created by Mary Martinez on 10/24/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var excerptLabel: UILabel!

    
    var review: Review! {
        didSet {
            usernameLabel.text = review.username
            excerptLabel.text = review.excerpt
            userImageView.setImageWith(review.userImageURL!)
            ratingImageView.setImageWith(review.ratingImageURL!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImageView.layer.cornerRadius = 3
        userImageView.clipsToBounds = true
    }

}
