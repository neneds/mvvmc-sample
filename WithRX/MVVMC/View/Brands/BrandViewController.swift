//
//  BrandViewController.swift
//  MVVMC
//
//  Created by Dennis Merli on 12/1/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import UIKit

protocol BrandViewControllerDelegate: class {
    func shouldPresentBrandVehicles(view: BrandViewController, sender: Any?)
}

class BrandViewController: BaseViewController<BrandViewModel>, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: BrandViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Brands"
        registerNibs()
        setupCollectionView()
    }

    func registerNibs() {
      collectionView.register(UINib(nibName: "BrandCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: BrandCollectionViewCell.reuseIdentifier)
    }

    // MARK: Setup collection view
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        let cellSize = CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height / 2)
        layout.itemSize = cellSize
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = -1
        collectionView.contentInset = UIEdgeInsets(top:0, left: 0, bottom: 0, right: 0)
        collectionView.collectionViewLayout = layout

    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let brands = viewModel?.brands else {
            return 0
        }

        return brands.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandCollectionViewCell.reuseIdentifier, for: indexPath) as? BrandCollectionViewCell else {
            return UICollectionViewCell()
        }
        let brand = viewModel?.brands[indexPath.row]
        cell.lblBrandName.text = brand?.name
        cell.lblBrandCompleteName.text = brand?.brandDescription
        cell.delegate = self
        if let imageURL = brand?.brandImageURL {
            UIImage.loadImageFromURL(url: imageURL).asObservable().subscribe(onNext: { [weak cell] (image) in
                guard let image = image else { return }
                cell?.imgBrand.image = image
            }).disposed(by: disposeBag)
        }
        return cell
    }

}

extension BrandViewController: BrandCollectionViewCellDelegate {
    func didPressMoreVehicles(cell: BrandCollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        let brand = viewModel?.brands[indexPath.row]
        delegate?.shouldPresentBrandVehicles(view: self, sender: brand)
    }
}



extension BrandViewController: BrandViewModelType {
    func reloadView() {
        collectionView.reloadData()
    }

    func showHUD() {
        self.showActivity()
    }

    func hideHUD() {
        self.hideActivity()
    }
}

