//
//  BaseCoordinator .swift
//  MVVMC
//
//  Created by Dennis Merli on 12/1/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation
import UIKit

class BaseCoordinator: Coordinator, Equatable {

    convenience init(navigationController: UINavigationController?) {
        self.init()
        guard let navigationController = navigationController else {
            return
        }
        self.coordinatorNavigationController = navigationController
    }
    
    private let identifier = UUID()
    var childCoordinators: [BaseCoordinator] = []
    weak var coordinatorNavigationController: UINavigationController?
    var freeCoordinatorCompletion: ((Coordinator?) -> Void)?

    private func store(coordinator: BaseCoordinator?) {
        guard let coordinator = coordinator else { return }
        childCoordinators.append(coordinator)
    }

    func free(coordinator: BaseCoordinator?) {
        guard let coordinator = coordinator else { return }
        coordinator.coordinatorNavigationController = nil
        childCoordinators.remove(object: coordinator)
    }

    func coordinate(to coordinator: BaseCoordinator?, completion: @escaping (UIViewController?) -> Void) {
        guard let coordinator = coordinator else { return }
        store(coordinator: coordinator)
        coordinator.start(completion: completion)
    }

    func start(completion: @escaping (UIViewController?) -> Void) {
    }

    static func == (lhs: BaseCoordinator, rhs: BaseCoordinator) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
}
