//
//  PlaceDetailTableViewCell.swift
//  DomoEats
//
//  Created by Timothy Barrett on 1/20/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import UIKit

class PlaceDetailTableViewCell: CellWithAccessoryButtonTableViewCell {
    
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemLabelContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func accessoryButtonWasPressed(sender: AnyObject) {
        self.delegate?.accessoryButtonWasPressedForCell(self)
    }

}
