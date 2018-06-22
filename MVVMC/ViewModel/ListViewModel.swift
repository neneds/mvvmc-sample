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

///Protocol to inform actions to coordinador
protocol ListViewModelCoordinatorDelegate: class {
    func shouldMakeSegue(viewModel: Any?, sender:Any?)
}

class ListViewModel: BaseViewModel {
    
    override init() {
        super.init()
        refreshVehicles()
    }

    var coordinatorDelegate: ListViewModelCoordinatorDelegate?
    var vehicles : [Vehicle] = []

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
    internal func loadVehicles(completion: @escaping ([Vehicle]?) -> ()) {
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

    ///React to tableview selection o view
    func didSelectIndexPath(indexPath: IndexPath) {
        let vehicle = self.vehicles[indexPath.row]
        self.coordinatorDelegate?.shouldMakeSegue(viewModel: self, sender: vehicle)
    }
}
