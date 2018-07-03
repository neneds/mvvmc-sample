//
//  AppCoordinator.swift
//  MVVMC
//
//  Created by Dennis Merli on 12/1/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: BaseCoordinator {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start(completion: @escaping (UIViewController?) -> ()) {
        let tabBarCoordinator = TabBarCoordinator(window: window)
        coordinate(to: tabBarCoordinator) { (_) in }
    }
}
