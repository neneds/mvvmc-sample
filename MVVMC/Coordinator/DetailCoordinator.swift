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

    var viewModel: DetailViewModel?
    convenience init(viewModel: DetailViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func start(completion: @escaping (UIViewController?) -> ()) {
        guard let viewModel = self.viewModel else {
            return
        }
        let viewController: DetailViewController = DetailViewController(viewModel: viewModel, nibName: DetailViewController.className, bundle: Bundle.main)
        viewController.delegate = self
        viewController.deinitCompletion = {() -> Void in
            self.freeCoordinatorCompletion(self)
        }
        completion(viewController)
    }
}

extension DetailCoordinator: DetailViewControllerDelegate {
    func shouldPresentBrandVehicles(viewController: DetailViewController?, sender: Any?) {
        guard let brand = sender as? Brand else { return }
        let brandVehiclesCoordinator = BrandVehiclesCoordinator(brand: brand)
        self.coordinate(to: brandVehiclesCoordinator) { (viewController) in
            guard let viewController = viewController else { return }
            self.coordinatorNavigationController?.pushViewController(viewController, animated: true)
        }
    }
}
