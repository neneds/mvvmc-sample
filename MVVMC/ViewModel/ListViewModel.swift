//
//  ListViewModel.swift
//  MVVMC
//
//  Created by Dennis Merli on 11/29/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation
import ObjectMapper

protocol ListViewModelType: class {
    func loadVehicles(completion: @escaping ([Vehicle]?) -> ())
}

class ListViewModel: BaseViewModel {

    var vehicles : [Vehicle] = []

    func refreshVehicles() {
        self.loadVehicles { (result) in
            if result != nil {
                self.vehicles = result!
                self.delegate?.reloadTableView()
            }
        }
    }

    ///Load data from an API
    internal func loadVehicles(completion: @escaping ([Vehicle]?) -> ()) {
        guard let json = Bundle.loadJSONFromBundle(resourceName: "vehicles") else {
            completion(nil)
            return
        }
        guard let vehicles = Mapper<Vehicle>().mapArray(JSONObject: json) else {
            completion(nil)
            return
        }

        completion(vehicles)
    }
}
