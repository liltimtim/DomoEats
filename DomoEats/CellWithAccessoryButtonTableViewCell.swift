//
//  CellWithAccessoryButtonTableViewCell.swift
//  DomoEats
//
//  Created by Timothy Barrett on 1/20/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import UIKit
protocol CellWithAccessoryButtonTableViewCellProtocol {
    func accessoryButtonWasPressedForCell(cell: UITableViewCell)
}
class CellWithAccessoryButtonTableViewCell: UITableViewCell {
    var delegate:CellWithAccessoryButtonTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
