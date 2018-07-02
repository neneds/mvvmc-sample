
//
//  BrandVehiclesViewModel.swift
//  MVVMC
//
//  Created by Dennis Merli Rodrigues on 02/07/18.
//  Copyright © 2018 Dennis Merli. All rights reserved.
//

import Foundation
import UIKit

///Specific methods that this viewModel should have
protocol BrandVehiclesViewModelType: ViewModelType {

}
class BrandVehiclesViewModel: BaseViewModel {

    // MARK: Properties
    private(set) var vehicles: [Vehicle] = []
    private(set) var currentBrand: Brand?

    override init() {
        super.init()
    }

    convenience init(brand: Brand?) {
        self.init()
        self.currentBrand = brand
    }

    func refreshVehicles(brandId: String?) {
        delegate?.showHUD()
        self.loadBrandVehicles(brandId: brandId) { [weak self] (result) in
            self?.delegate?.hideHUD()
            guard let result = result else { return }
            self?.vehicles = result
            self?.delegate?.reloadView()
        }
    }

    ///Load data from an API
    private func loadBrandVehicles(brandId: String?, completion: @escaping ([Vehicle]?) -> ()) {
        guard let brandId = brandId else {
            completion(nil)
            return
        }
        
        var fileName = ""
        switch brandId {
        case "004":
            fileName = "fordVehicles"
        case "002":
            fileName = "kiaVehicles"
        case "001":
            fileName = "teslaVehicles"
        case "003":
            fileName = "toyotaVehicles"
        default:
            break
        }
        guard let json = Bundle.loadJSONDataFromBundle(resourceName: fileName) else {
            completion(nil)
            return
        }
        guard let vehicles: [Vehicle] = try? [Vehicle].decode(data: json) else {
            completion(nil)
            return
        }

        completion(vehicles)
    }

    func loadBrandImage(completion: @escaping (_ image: UIImage?) -> ()) {
        if let imageURL = currentBrand?.brandImageURL {
            UIImage.loadImageFromURL(imageURL) { (resultImage) in
                completion(resultImage)
            }
        }
    }
}
