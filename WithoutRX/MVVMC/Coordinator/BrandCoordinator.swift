//
//  BrandCoordinator.swift
//  MVVMC
//
//  Created by Dennis Merli on 12/1/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation
import UIKit

class BrandCoordinator: BaseCoordinator {
    
    override func start(completion: @escaping (UIViewController?) -> ()) {
        let brandViewController: BrandViewController = BrandViewController(viewModel: BrandViewModel(), nibName: BrandViewController.className, bundle: Bundle.main)
        brandViewController.delegate = self
        coordinatorNavigationController?.viewControllers.append(brandViewController)
        completion(coordinatorNavigationController)
    }
}

extension BrandCoordinator: BrandViewControllerDelegate {
    func shouldPresentBrandVehicles(view: BrandViewController, sender: Any?) {
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
