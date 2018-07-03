//
//  ListViewController.swift
//  MVVMC
//
//  Created by Dennis Merli on 11/29/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import UIKit


///Protocol to inform actions to coordinador
protocol VehicleListViewControllerDelegate: class {
    func shouldMakeSegue(viewController: VehicleListViewController?, sender:Any?)
}

class VehicleListViewController: BaseViewController<VehicleListViewModel>, UITableViewDelegate, UITableViewDataSource {
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(reloadList),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.darkGray
        
        return refreshControl
    }()
    
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: VehicleListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Electric Vehicles"
        viewModel?.delegate = self
        setupTableView()
        viewModel?.refreshVehicles()
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "VehicleTableViewCell", bundle: nil), forCellReuseIdentifier: VehicleTableViewCell.reuseIdentifier)
        self.tableView.addSubview(self.refreshControl)
    }
    
    @objc private func reloadList(_ refreshControl: UIRefreshControl) {
        viewModel?.refreshVehicles()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vehicle = viewModel?.vehicles[indexPath.row] else { return }
        delegate?.shouldMakeSegue(viewController: self, sender: vehicle)
    }
}

extension VehicleListViewController : ViewModelType {
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
