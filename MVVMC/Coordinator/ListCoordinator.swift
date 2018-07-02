//
//  ListCoordinator.swift
//  MVVMC
//
//  Created by Dennis Merli on 11/29/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation
import UIKit

class ListCoordinator: BaseCoordinator {
    
    override func start(completion: @escaping (UIViewController?) -> ()) {
        let viewModel = VehicleListViewModel()
        let vehicleListViewController : VehicleListViewController = VehicleListViewController(viewModel: viewModel , nibName: VehicleListViewController.className, bundle: Bundle.main)
        vehicleListViewController.delegate = self
        coordinatorNavigationController?.viewControllers.append(vehicleListViewController)
        completion(coordinatorNavigationController)
    }
}

extension ListCoordinator : VehicleListViewControllerDelegate {
    func shouldMakeSegue(viewController: VehicleListViewController?, sender: Any?) {
        let viewModel = DetailViewModel(vehicle: sender as? Vehicle)
        let detailCoordinator = DetailCoordinator(viewModel: viewModel)
        detailCoordinator.coordinatorNavigationController = coordinatorNavigationController
        self.coordinate(to: detailCoordinator) { [weak self] (viewController) in
            guard let viewController = viewController else {
                return
            }
            self?.coordinatorNavigationController?.pushViewController(viewController, animated: true)
        }
        detailCoordinator.freeCoordinatorCompletion = {(coordinator: Coordinator?) -> Void in
            self.free(coordinator: coordinator as? BaseCoordinator)
        }
    }
}
