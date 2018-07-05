//
//  DetailViewModel.swift
//  MVVMC
//
//  Created by Dennis Merli on 12/4/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation
import RxCocoa

class DetailViewModel: BaseViewModel {

    var currentVehicle = BehaviorRelay<Vehicle?>(value: nil)

    convenience init(vehicle: Vehicle?) {
        self.init()
        self.currentVehicle.accept(vehicle)
    }
}
