//
//  BrandCollectionViewCell.swift
//  MVVMC
//
//  Created by Dennis Merli Rodrigues on 04/12/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import UIKit

class BrandCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "BrandCollectionViewCell"

    @IBOutlet weak var imgBrand: UIImageView!
    @IBOutlet weak var lblBrandName: UILabel!
    @IBOutlet weak var lblBrandCompleteName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
