//
//  DetailViewController.swift
//  MVVMC
//
//  Created by Dennis Merli on 11/29/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController<DetailViewModel> {

    @IBOutlet weak var btnMoreVehicles: UIButton!
    @IBOutlet weak var imgVehicle: UIImageView!
    @IBOutlet weak var lblBrandName: UILabel!
    @IBOutlet weak var lblModelName: UILabel!
    @IBOutlet weak var txtModelDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }

    func bindData() {
        lblBrandName.text = viewModel?.currentVehicle?.brand?.name
        lblModelName.text = viewModel?.currentVehicle?.name
        txtModelDescription.text = viewModel?.currentVehicle?.vehicleDescription
        if let imageURL = viewModel?.currentVehicle?.urlImage {
            UIImage.loadImageFromURL(imageURL) { [weak self] (resultImage) in
                guard let resultImage = resultImage else {
                    return
                }
                self?.imgVehicle.image = resultImage
            }
        }
    }
    
    
    @IBAction func actionMoreVehicles(_ sender: Any) {
    }
    
    deinit {
        deinitCompletion()
    }
}
