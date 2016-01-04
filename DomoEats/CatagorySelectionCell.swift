//
//  CatagorySelectionCell.swift
//  DomoEats
//
//  Created by Timothy Barrett on 1/3/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import UIKit

class CatagorySelectionCell: UITableViewCell {

    @IBOutlet weak var placeRating: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeAddressLine1: UILabel!
    @IBOutlet weak var placeAddressLine2: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
