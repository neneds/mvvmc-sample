//
//  ListCoordinator.swift
//  MVVMC
//
//  Created by Dennis Merli on 11/29/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation
import UIKit

class ListCoordinator: BaseCoordinator<Void> {
    
    override func start(completion: @escaping (UIViewController?) -> ()) {
        guard let vc = ListViewController(viewModel: ListViewModel(), nibName: ListViewController.className, bundle: Bundle.main) as? ListViewController else {
            return
        }
        completion(vc)
    }
}
