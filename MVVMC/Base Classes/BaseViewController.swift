//
//  BaseViewController.swift
//  MVVMC
//
//  Created by Dennis Merli on 11/29/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//


import UIKit

class BaseViewController<T: BaseViewModel>: UIViewController {
    
    private(set) var viewModel: T?
    var deinitCompletion: (() -> Void)!
    
    init(viewModel: T, nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        configure(viewModel: viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: T) {}
}
