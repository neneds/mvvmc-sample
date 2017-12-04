//
//  ListViewController.swift
//  MVVMC
//
//  Created by Dennis Merli on 11/29/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import UIKit

class ListViewController: BaseViewController<ListViewModel>, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Car List"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "VehicleTableViewCell", bundle: nil), forCellReuseIdentifier: VehicleTableViewCell.reuseIdentifier)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.vehicles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VehicleTableViewCell.reuseIdentifier, for: indexPath) as? VehicleTableViewCell else {
            return UITableViewCell()
        }

        let vehicle = viewModel?.vehicles[indexPath.row]
        
        if let imageURL = vehicle?.urlImage {
            UIImage.loadImageFromURL(imageURL) { (resultImage) in
                guard let resultImage = resultImage else {
                    return
                }
                cell.imgVehicle.image = resultImage
            }
        }
        cell.lblVehicleName.text = vehicle?.name
        cell.selectionStyle = .none
        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel?.didSelectIndexPath(indexPath: indexPath)
    }
}


extension ListViewController : ListViewModelType {
    func reloadView() {
        tableView.reloadData()
    }

    func showHUD() {
       self.view.lockView()
    }

    func hideHUD() {
       self.view.unlockView()
    }
}


