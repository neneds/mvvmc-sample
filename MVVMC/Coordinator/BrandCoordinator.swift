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
        let vc: BrandViewController = BrandViewController(viewModel: BrandViewModel(), nibName: BrandViewController.className, bundle: Bundle.main)
        coordinatorNavigationController?.viewControllers.append(vc)
        completion(coordinatorNavigationController)
    }
}
