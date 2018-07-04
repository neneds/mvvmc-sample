//
//  BrandVehiclesViewController.swift
//  MVVMC
//
//  Created by Dennis Merli Rodrigues on 02/07/18.
//  Copyright © 2018 Dennis Merli. All rights reserved.
//

import UIKit
import RxCocoa

class BrandVehiclesViewController: BaseViewController<BrandVehiclesViewModel>, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTitleView()
        setupBindings()
        refreshControl.sendActions(for: .valueChanged)
        viewModel?.loadBrandVehicles()
    }

    private func setupBindings() {
        viewModel?.vehicles
            .do(onNext: { [weak self] _ in self?.refreshControl.endRefreshing() })
            .bind(to: tableView.rx.items(cellIdentifier: VehicleTableViewCell.reuseIdentifier, cellType: VehicleTableViewCell.self)) { [weak self] (row, vehicle, cell) in
                self?.setupVehicleCell(cell: cell, vehicle: vehicle)
            }
            .disposed(by: disposeBag)

        refreshControl.rx.controlEvent(.valueChanged)
            .asDriver().do(onNext: { [weak self] (_) in
                self?.viewModel?.loadBrandVehicles()
            })


    }

    private func setupVehicleCell(cell: VehicleTableViewCell?, vehicle: Vehicle?) {
        guard let vehicle = vehicle else { return }
        guard let cell = cell else { return }
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
    }

    private func setupTableView() {
        self.tableView.rx.setDelegate(self).disposed(by: disposeBag)
        self.tableView.register(UINib(nibName: "VehicleTableViewCell", bundle: nil), forCellReuseIdentifier: VehicleTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.insertSubview(refreshControl, at: 0)
    }

    private func setupTitleView() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 30))
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        viewModel?.loadBrandImage(completion: { (resultImage) in
            DispatchQueue.main.async {
                guard let image = resultImage else { return }
                imageView.image = image
            }
        })
    }
}

