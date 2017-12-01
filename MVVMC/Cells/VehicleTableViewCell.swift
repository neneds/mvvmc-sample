//
//  VehicleTableViewCell.swift
//  MVVMC
//
//  Created by Dennis Merli on 12/1/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import UIKit

class VehicleTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "VehicleTableViewCell"

    @IBOutlet weak var lblVehicleName: UILabel!
    @IBOutlet weak var imgVehicle: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
