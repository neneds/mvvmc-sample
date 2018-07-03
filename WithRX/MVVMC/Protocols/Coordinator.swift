//
//  Coordinator.swift
//  MVVMC
//
//  Created by Dennis Merli on 11/29/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//


import UIKit

protocol Coordinator: class {
    func start(completion: @escaping (UIViewController?) -> ())
}
