//
//  ListViewModel.swift
//  MVVMC
//
//  Created by Dennis Merli on 11/29/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation

///Specific methods that this viewModel should have
protocol ListViewModelType: ViewModelType {

}
class VehicleListViewModel: BaseViewModel {
    
    override init() {
        super.init()
    }

    var vehicles: [Vehicle] = []

    func refreshVehicles() {
        delegate?.showHUD()
        self.loadVehicles { [weak self] (result) in
            self?.delegate?.hideHUD()
            guard let result = result else { return }
            self?.vehicles = result
            self?.delegate?.reloadView()
        }
    }

    ///Load data from an API
    private func loadVehicles(completion: @escaping ([Vehicle]?) -> ()) {
        guard let json = Bundle.loadJSONDataFromBundle(resourceName: "vehicles") else {
            completion(nil)
            return
        }
        guard let vehicles: [Vehicle] = try? [Vehicle].decode(data: json) else {
            completion(nil)
            return
        }

        completion(vehicles)
    }
}
