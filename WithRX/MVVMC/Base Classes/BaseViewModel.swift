//
//  BaseViewModel.swift
//  MVVMC
//
//  Created by Dennis Merli Rodrigues on 01/12/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation
import RxSwift

class BaseViewModel: NSObject {

    // MARK: Properties
    weak var delegate: ViewModelType?
    var disposeBag: DisposeBag = DisposeBag()
}
