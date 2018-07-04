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
            UIImage.loadImageFromURL(url: imageURL).asObservable().subscribe(onNext: { [weak self] (image) in
                guard let image = image else { return }
                self?.imgVehicle.image = image
            }).disposed(by: disposeBag)
        }
    }

    @IBAction func actionLike(_ sender: Any) {
        viewModel?.didClickLike()
    }
    
}
