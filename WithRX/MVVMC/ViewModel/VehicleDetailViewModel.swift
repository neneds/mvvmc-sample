//
//  VehicleDetailViewModel.swift
//  MVVMC
//
//  Created by Dennis Merli Rodrigues on 04/12/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation


class VehicleDetailViewModel: BaseViewModel {
    var currentVehicle: Vehicle?

    convenience init(vehicle: Vehicle?) {
        self.init()
        self.currentVehicle = vehicle
    }
}

