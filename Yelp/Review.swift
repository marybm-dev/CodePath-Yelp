//
//  Review.swift
//  Yelp
//
//  Created by Mary Martinez on 10/24/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import Foundation

class Review: NSObject {
    let ratingImageURL: URL?
    let userImageURL: URL?
    let username: String?
    let excerpt: String?
    
    init(dictionary: NSDictionary) {
        let ratingImageURLString = dictionary["image_url"] as? String
        if ratingImageURLString != nil {
            ratingImageURL = URL(string: ratingImageURLString!)!
        } else {
            ratingImageURL = nil
        }
        
        let user = dictionary["user"] as? NSDictionary
        var name = ""
        if user != nil {
            let userImageURLString = user?["image_url"] as? String
            if userImageURLString != nil {
                self.userImageURL = URL(string: userImageURLString!)!
            }
            else {
                self.userImageURL = nil
            }
            
            name = (user?["name"] as? String)!
        }
        else {
            self.userImageURL = nil
        }
        self.username = name
        
        excerpt = dictionary["excerpt"] as? String
    }
    
    class func reviews(array: [NSDictionary]) -> [Review] {
        var reviews = [Review]()
        for dictionary in array  {
            let review = Review(dictionary: dictionary)
            reviews.append(review)
        }
        return reviews
    }
}
