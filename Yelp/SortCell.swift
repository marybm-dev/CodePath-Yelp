//
//  SortCell.swift
//  Yelp
//
//  Created by Mary Martinez on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SortCellDelegate {
    @objc optional func sortCell(sortCell: SortCell, didChangeValue value: Int)
}

class SortCell: UITableViewCell {
    
    @IBOutlet weak var sortSegmentControl: UISegmentedControl!
    
    weak var delegate: SortCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sortSegmentControl.addTarget(self, action: #selector(SortCell.segmentValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func segmentValueChanged() {
        if delegate != nil {
            delegate?.sortCell!(sortCell: self, didChangeValue: sortSegmentControl.selectedSegmentIndex)
        }
    }

}
