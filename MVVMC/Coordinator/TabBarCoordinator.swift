//
//  TabBarCoordinator.swift
//  MVVMC
//
//  Created by Dennis Merli on 12/1/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation
import UIKit


class TabBarCoordinator: BaseCoordinator {
    
    private let window: UIWindow
    
    let tabBarController = UITabBarController()
    var tabBarControllers = [UIViewController]()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start(completion: @escaping (UIViewController?) -> ()) {
        
        //Instantiate tabbar items coordinators
        
        let listCoordinator = ListCoordinator(navigationController: UINavigationController())
        listCoordinator.start { [weak self] (resultViewController) in
            guard let resultViewController = resultViewController else {
                return
            }
            resultViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
            self?.tabBarControllers.append(resultViewController)
        }
        
        let brandsCoordinator = BrandCoordinator(navigationController: UINavigationController())
        brandsCoordinator.start { [weak self] (resultViewController) in
            guard let resultViewController = resultViewController else {
                return
            }
            resultViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
            self?.tabBarControllers.append(resultViewController)
        }
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        tabBarController.viewControllers = tabBarControllers
        completion(tabBarController)
    }
}
