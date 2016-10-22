//
//  BusinessCell.swift
//  Yelp
//
//  Created by Mary Martinez on 10/22/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var reviewsCountLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!

    
    var business: Business! {
        didSet {
            thumbImageView.setImageWith(business.imageURL!)
            nameLabel.text = business.name!
            ratingImageView.setImageWith(business.ratingImageURL!)
            addressLabel.text = business.address!
            categoriesLabel.text = business.categories!
            reviewsCountLabel.text = "\(business.reviewCount!) Reviews"
            distanceLabel.text = business.distance!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        thumbImageView.layer.cornerRadius = 3
        thumbImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
