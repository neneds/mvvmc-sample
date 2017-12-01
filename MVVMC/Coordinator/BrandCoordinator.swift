//
//  BrandCoordinator.swift
//  MVVMC
//
//  Created by Dennis Merli on 12/1/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation

import UIKit

class BrandCoordinator: BaseCoordinator<Void> {
    
    override func start(completion: @escaping (UIViewController?) -> ()) {
        guard let vc = BrandViewController(viewModel: BrandViewModel(), nibName: BrandViewController.className, bundle: Bundle.main) as? BrandViewController else {
            return
        }
        self.navigationController?.viewControllers.append(vc)
        completion(vc)
    }
}
