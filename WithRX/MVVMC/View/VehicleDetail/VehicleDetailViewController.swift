//
//  VehicleDetailViewController.swift
//  MVVMC
//
//  Created by Dennis Merli Rodrigues on 04/12/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import UIKit

class VehicleDetailViewController: BaseViewController<VehicleDetailViewModel> {

    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var imgVehicle: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadVehicleImage()
    }

    func loadVehicleImage() {
        if let imageURL = viewModel?.currentVehicle?.urlImage {
            UIImage.loadImageFromURL(imageURL) { (resultImage) in
                guard let resultImage = resultImage else {
                    return
                }
                self.imgVehicle.image = resultImage
            }
        }
    }

    @IBAction func actionLike(_ sender: Any) {
        viewModel?.didClickLike()
    }
    
}
