
//
//  BrandVehiclesViewModel.swift
//  MVVMC
//
//  Created by Dennis Merli Rodrigues on 02/07/18.
//  Copyright © 2018 Dennis Merli. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class BrandVehiclesViewModel: BaseViewModel {

    // MARK: Properties
    var vehicles = BehaviorRelay<[Vehicle]>(value: [])
    var currentBrand = BehaviorRelay<Brand>(value: Brand())
    var isLoading = BehaviorRelay<Bool>(value: false)

    override init() {
        super.init()
    }

    convenience init(brand: Brand?) {
        self.init()
        guard let unwrappedBrand = brand else { return }
        self.currentBrand.accept(unwrappedBrand)
    }

    ///Load data from an API
    func loadBrandVehicles() {
        guard let brandId = currentBrand.value.id else { return }
        isLoading.accept(true)
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
        guard let json = Bundle.loadJSONDataFromBundle(resourceName: fileName) else { return }
        guard let loadedVehicles: [Vehicle] = try? [Vehicle].decode(data: json) else { return }
        isLoading.accept(false)
        vehicles.accept(loadedVehicles)
    }

    func loadBrandImage(completion: @escaping (_ image: UIImage?) -> ()) {
        if let imageURL = currentBrand.value.brandImageURL {
            UIImage.loadImageFromURL(imageURL) { (resultImage) in
                completion(resultImage)
            }
        }
    }
}
