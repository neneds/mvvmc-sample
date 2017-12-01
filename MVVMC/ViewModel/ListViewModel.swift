//
//  ListViewModel.swift
//  MVVMC
//
//  Created by Dennis Merli on 11/29/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import Foundation


protocol ListViewModelType: ViewModelType {
    func loadVehicles(completion: @escaping ([Vehicle]?) -> ())
}

class ListViewModel: ListViewModelType {
    
    func reloadTableView() {
        
    }
    
    func showHUD() {
        
    }
    
    func hideHUD() {
        
    }
    
    func loadVehicles(completion: @escaping ([Vehicle]?) -> ()) {
        
    }
}
