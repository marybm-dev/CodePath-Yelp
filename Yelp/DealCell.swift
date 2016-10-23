//
//  DealCell.swift
//  Yelp
//
//  Created by Mary Martinez on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol DealCellDelegate {
    @objc optional func dealCell(dealCell: DealCell, didChangeValue value: Bool)
}

class DealCell: UITableViewCell {

    @IBOutlet weak var onOffSwitch: UISwitch!
    
    weak var delegate: DealCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        onOffSwitch.addTarget(self, action: #selector(DealCell.switchValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func switchValueChanged() {
        if delegate != nil {
            delegate?.dealCell!(dealCell: self, didChangeValue: onOffSwitch.isOn)
        }
    }
    
}
