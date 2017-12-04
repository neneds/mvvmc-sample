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
        let vc: DetailViewController = DetailViewController(viewModel: viewModel, nibName: DetailViewController.className, bundle: Bundle.main)
        completion(vc)
    }
}
