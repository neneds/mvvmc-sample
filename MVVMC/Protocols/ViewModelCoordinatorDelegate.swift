//
//  ViewModelCoordinatorDelegate.swift
//  MVVMC
//
//  Created by Dennis Merli Rodrigues on 03/12/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation


protocol ViewModelCoordinatorDelegate : class {
    func shouldMakeSegue(identifier: Any?, sender:Any?)
}
