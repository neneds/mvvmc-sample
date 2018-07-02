//
//  BrandVehiclesViewController.swift
//  MVVMC
//
//  Created by Dennis Merli Rodrigues on 02/07/18.
//  Copyright © 2018 Dennis Merli. All rights reserved.
//

import UIKit

class BrandVehiclesViewController: BaseViewController<BrandVehiclesViewModel>, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(reloadList),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.darkGray

        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel?.refreshVehicles(brandId: viewModel?.currentBrand?.id)
    }

    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "VehicleTableViewCell", bundle: nil), forCellReuseIdentifier: VehicleTableViewCell.reuseIdentifier)
        self.tableView.addSubview(self.refreshControl)
    }

    @objc private func reloadList(_ refreshControl: UIRefreshControl) {
        viewModel?.refreshVehicles(brandId: viewModel?.currentBrand?.id)
        refreshControl.endRefreshing()
    }

    // MARK: Table view methods
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
}

extension BrandVehiclesViewController: ViewModelType {
    func reloadView() {
        tableView.reloadData()
    }

    func showHUD() {
        self.showActivity()
    }

    func hideHUD() {
        self.hideActivity()
    }
}
