//
//  BaseCoordinator .swift
//  MVVMC
//
//  Created by Dennis Merli on 12/1/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation
import UIKit

class BaseCoordinator: Coordinator {
  
    convenience init(navigationController: UINavigationController?) {
        self.init()
        guard let navigationController = navigationController else {
            return
        }
        self.coordinatorNavigationController = navigationController
    }

    private let identifier = UUID()
    private var childCoordinators = [UUID: Any]()
    var coordinatorNavigationController: UINavigationController?

    private func store(coordinator: BaseCoordinator) {
        childCoordinators[coordinator.identifier] = coordinator
    }

    private func free(coordinator: BaseCoordinator) {
        childCoordinators[coordinator.identifier] = nil
    }

    func coordinate(to coordinator: BaseCoordinator, completion: @escaping (UIViewController?) -> Void) {
        store(coordinator: coordinator)
        coordinator.start(completion: completion)
    }

    func start(completion: @escaping (UIViewController?) -> Void) {
    }
    
}
