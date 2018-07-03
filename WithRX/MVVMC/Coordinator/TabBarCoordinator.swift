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
    private var  listCoordinator: ListCoordinator?
    private var  brandsCoordinator: BrandCoordinator?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start(completion: @escaping (UIViewController?) -> ()) {
        
        //Instantiate tabbar items coordinators
        let nav1 = UINavigationController()
        listCoordinator = ListCoordinator(navigationController: nav1)
        guard let listCoordinator = listCoordinator else {return}
        listCoordinator.start { [weak self] (resultViewController) in
            guard let resultViewController = resultViewController else {
                return
            }
            resultViewController.tabBarItem = UITabBarItem(title: "Vehicles", image: #imageLiteral(resourceName: "ev"), tag: 0)
            self?.tabBarControllers.append(resultViewController)
        }

        let nav2 = UINavigationController()
        brandsCoordinator = BrandCoordinator(navigationController: nav2)
        guard let brandsCoordinator = brandsCoordinator else {return}
        brandsCoordinator.start { [weak self] (resultViewController) in
            guard let resultViewController = resultViewController else {
                return
            }
            resultViewController.tabBarItem = UITabBarItem(title: "Brands", image: #imageLiteral(resourceName: "factory"), tag: 1)
            self?.tabBarControllers.append(resultViewController)
        }
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        tabBarController.viewControllers = tabBarControllers
        completion(tabBarController)
    }
}
