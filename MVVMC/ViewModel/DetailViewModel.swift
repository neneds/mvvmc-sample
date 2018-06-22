//
//  DetailViewModel.swift
//  MVVMC
//
//  Created by Dennis Merli on 12/4/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation

class DetailViewModel: BaseViewModel {
    var currentVehicle: Vehicle?

    convenience init(vehicle: Vehicle?) {
        self.init()
        self.currentVehicle = vehicle
    }
}
