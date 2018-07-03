//
//  BrandCollectionViewCell.swift
//  MVVMC
//
//  Created by Dennis Merli Rodrigues on 04/12/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import UIKit

protocol BrandCollectionViewCellDelegate: class {
    func didPressMoreVehicles(cell: BrandCollectionViewCell)
}

class BrandCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "BrandCollectionViewCell"

    @IBOutlet weak var btnBrandVehicles: UIButton!
    @IBOutlet weak var imgBrand: UIImageView!
    @IBOutlet weak var lblBrandName: UILabel!
    @IBOutlet weak var lblBrandCompleteName: UILabel!

    weak var delegate: BrandCollectionViewCellDelegate?

    @IBAction func actionMoreVehicles(_ sender: Any) {
        delegate?.didPressMoreVehicles(cell: self)
    }
}
