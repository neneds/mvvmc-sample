//
//  ListViewModel.swift
//  MVVMC
//
//  Created by Dennis Merli on 11/29/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation
import RxSwift

///Specific methods that this viewModel should have
protocol ListViewModelType: ViewModelType {

}
class VehicleListViewModel: BaseViewModel {
    
    override init() {
        super.init()
    }

    var vehicles = BehaviorSubject<[Vehicle]>(value: [])
    var isLoading = BehaviorSubject<Bool>(value: false)

    func refreshVehicles() {
        delegate?.showHUD()
        self.loadVehicles()
    }

    ///Load data from an API
    private func loadVehicles() {
        isLoading.onNext(true)
        guard let json = Bundle.loadJSONDataFromBundle(resourceName: "vehicles") else { return }
        guard let loadedVehicles: [Vehicle] = try? [Vehicle].decode(data: json) else { return }
        vehicles.onNext(loadedVehicles)
        isLoading.onNext(false)
    }
}
