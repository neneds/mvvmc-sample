//
//  BrandViewModel.swift
//  MVVMC
//
//  Created by Dennis Merli on 12/1/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation
import ObjectMapper

protocol BrandViewModelType: ViewModelType {
  
}

class BrandViewModel: BaseViewModel {

    var brands : [Brand] = []

    override init() {
        super.init()
        refreshBrands()
    }

    func refreshBrands() {
        delegate?.showHUD()
        self.loadBrands { [weak self] (result) in
            self?.delegate?.hideHUD()
            if result != nil {
                self?.brands = result!
                self?.delegate?.reloadView()
            }
        }
    }

    ///Load data from an API
    internal func loadBrands(completion: @escaping ([Brand]?) -> ()) {
        guard let json = Bundle.loadJSONFromBundle(resourceName: "brands") else {
            completion(nil)
            return
        }
        guard let brands = Mapper<Brand>().mapArray(JSONObject: json) else {
            completion(nil)
            return
        }

        completion(brands)
    }
}
