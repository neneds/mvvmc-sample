//
//  BaseCoordinator .swift
//  MVVMC
//
//  Created by Dennis Merli on 12/1/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation
import UIKit

class BaseCoordinator<ResultType>: Coordinator {
  
    convenience init(navigationController: UINavigationController?) {
        self.init()
        guard let navigationController = navigationController else {
            return
        }
        self.navigationController = navigationController
    }

    typealias CoordinationResult = ResultType

    private let identifier = UUID()
    private var childCoordinators = [UUID: Any]()
    var rootViewController: UIViewController?
    var navigationController: UINavigationController? {
        didSet {
            self.rootViewController = navigationController
        }
    }
    private func store<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = coordinator
    }
   
    private func free<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = nil
    }
    

    func coordinate<T>(to coordinator: BaseCoordinator<T>) {
        store(coordinator: coordinator)
        coordinator.start { (_) in}
    }
        
    func start(completion: @escaping (UIViewController?) -> ()) {
        
    }
    
}
