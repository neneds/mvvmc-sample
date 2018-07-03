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
            #selector(reloadList), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.darkGray
        
        return refreshControl
    }()
    
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: VehicleListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Electric Vehicles"
        setupTableView()
        viewModel?.refreshVehicles()
    }

    private func setupBindings() {
        viewModel?.vehicles.asObserver().subscribe(onNext: { [weak self] (_) in
            self?.tableView.reloadData()
        })

        viewModel?.isLoading.asObserver().subscribe(onNext: { [weak self] (isLoading) in
            if isLoading{
                self?.showActivity()
            } else {
                self?.hideActivity()
            }
        })
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
        guard let viewModel = viewModel else { return 0 }
        guard let value = try? viewModel.vehicles.value().count else { return 0 }
        return value
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VehicleTableViewCell.reuseIdentifier, for: indexPath) as? VehicleTableViewCell else {
            return UITableViewCell()
        }
        guard let viewModel = viewModel else { return UITableViewCell()}
        guard let vehicle = try? viewModel.vehicles.value()[indexPath.row] else { return UITableViewCell() }

        if let imageURL = vehicle.urlImage {
            UIImage.loadImageFromURL(imageURL) { (resultImage) in
                guard let resultImage = resultImage else {
                    return
                }
                cell.imgVehicle.image = resultImage
            }
        }
        cell.lblVehicleName.text = vehicle.name
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        guard let vehicle = try? viewModel.vehicles.value()[indexPath.row] else { return }
        delegate?.shouldMakeSegue(viewController: self, sender: vehicle)
    }
}
