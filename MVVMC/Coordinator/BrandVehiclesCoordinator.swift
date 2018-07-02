//
//  BrandVehiclesCoordinator.swift
//  MVVMC
//
//  Created by Dennis Merli Rodrigues on 02/07/18.
//  Copyright © 2018 Dennis Merli. All rights reserved.
//

import Foundation
import UIKit

class BrandVehiclesCoordinator: BaseCoordinator {
    private(set) var currentBrand: Brand?

    convenience init(brand: Brand) {
        self.init()
        self.currentBrand = brand
    }

    override func start(completion: @escaping (UIViewController?) -> ()) {
        let brandVehiclesViewController: BrandVehiclesViewController = BrandVehiclesViewController(viewModel: BrandVehiclesViewModel(brand: currentBrand), nibName: BrandVehiclesViewController.className, bundle: Bundle.main)
        completion(brandVehiclesViewController)
    }
}

