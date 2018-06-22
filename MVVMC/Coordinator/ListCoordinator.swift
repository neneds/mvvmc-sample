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
        let viewModel = ListViewModel()
        viewModel.coordinatorDelegate = self
        let vc : VehicleListViewController = VehicleListViewController(viewModel: viewModel , nibName: VehicleListViewController.className, bundle: Bundle.main)
        coordinatorNavigationController?.viewControllers.append(vc)
        completion(coordinatorNavigationController)
    }
}

extension ListCoordinator : ListViewModelCoordinatorDelegate {
    func shouldMakeSegue(viewModel: Any?, sender: Any?) {
        let viewModel = DetailViewModel(vehicle: sender as? Vehicle)
        let detailCoordinator = DetailCoordinator(viewModel: viewModel)
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
