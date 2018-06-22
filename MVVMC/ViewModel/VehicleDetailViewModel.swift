//
//  VehicleDetailViewModel.swift
//  MVVMC
//
//  Created by Dennis Merli Rodrigues on 04/12/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation

///Protocol to inform actions to coordinador
protocol VehicleDetailCoordinatorDelegate: class {
    func didClickLike(viewModel: Any?, sender:Any?)
}

class VehicleDetailViewModel: BaseViewModel {
    var currentVehicle: Vehicle?
    var coordinatorDelegate: VehicleDetailCoordinatorDelegate?

    convenience init(vehicle: Vehicle?) {
        self.init()
        self.currentVehicle = vehicle
    }

    func didClickLike() {
        self.coordinatorDelegate?.didClickLike(viewModel: self, sender: nil)
    }


}

