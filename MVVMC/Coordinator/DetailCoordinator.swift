//
//  DetailCoordinator.swift
//  MVVMC
//
//  Created by Dennis Merli Rodrigues on 04/12/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation
import UIKit

class DetailCoordinator: BaseCoordinator {

    private(set) var vehicle: Vehicle?
    convenience init(vehicle: Vehicle?) {
        self.init()
        self.vehicle = vehicle
    }
    
    override func start(completion: @escaping (UIViewController?) -> ()) {
        let viewModel = DetailViewModel(vehicle: vehicle)
        let viewController: DetailViewController = DetailViewController(viewModel: viewModel, nibName: DetailViewController.className, bundle: Bundle.main)
        viewController.delegate = self
        viewController.baseViewControllerDelegate = self
        completion(viewController)
    }
}

extension DetailCoordinator: BaseViewControllerDelegate {
    func willDeallocate(viewController: BaseViewController<BaseViewModel>?) {
        self.freeCoordinatorCompletion?(self)
    }
}

extension DetailCoordinator: DetailViewControllerDelegate {
    func shouldPresentBrandVehicles(viewController: DetailViewController?, sender: Any?) {
        guard let brand = sender as? Brand else { return }
        let brandVehiclesCoordinator = BrandVehiclesCoordinator(brand: brand)
        brandVehiclesCoordinator.coordinatorNavigationController = coordinatorNavigationController
        self.coordinate(to: brandVehiclesCoordinator) { (viewController) in
            guard let viewController = viewController as? BrandVehiclesViewController else { return }
            brandVehiclesCoordinator.coordinatorNavigationController?.pushViewController(viewController, animated: true)
        }
        brandVehiclesCoordinator.freeCoordinatorCompletion = {(coordinator: Coordinator?) -> Void in
            self.free(coordinator: coordinator as? BaseCoordinator)
        }
    }
}
