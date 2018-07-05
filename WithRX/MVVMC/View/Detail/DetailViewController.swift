//
//  DetailViewController.swift
//  MVVMC
//
//  Created by Dennis Merli on 11/29/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import UIKit

///Protocol to inform actions to coordinador
protocol DetailViewControllerDelegate: class {
    func shouldPresentBrandVehicles(viewController: DetailViewController?, sender:Any?)
}


class DetailViewController: BaseViewController<DetailViewModel> {

    @IBOutlet weak var btnMoreVehicles: UIButton!
    @IBOutlet weak var imgVehicle: UIImageView!
    @IBOutlet weak var lblBrandName: UILabel!
    @IBOutlet weak var lblModelName: UILabel!
    @IBOutlet weak var txtModelDescription: UITextView!

    weak var delegate: DetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    func setupBindings() {
        viewModel?.currentVehicle.asDriver().drive(onNext: { [weak self] (vehicle) in
            self?.lblBrandName.text = vehicle?.brand?.name
            self?.lblModelName.text = vehicle?.name
            self?.txtModelDescription.text = vehicle?.vehicleDescription
            self?.loadVehicleImage(imageURL: vehicle?.urlImage)
        }).disposed(by: disposeBag)
    }

    func loadVehicleImage(imageURL: URL?) {
        guard let imageURL = imageURL else { return }
        UIImage.loadImageFromURL(url: imageURL).asObservable().subscribe(onNext: { [weak self] (image) in
            guard let image = image else { return }
            self?.imgVehicle.image = image
        }).disposed(by: disposeBag)
    }

    @IBAction func actionMoreVehicles(_ sender: Any) {
        guard let vehicle = viewModel?.currentVehicle.value else { return }
        delegate?.shouldPresentBrandVehicles(viewController: self, sender: vehicle.brand)
    }
}
