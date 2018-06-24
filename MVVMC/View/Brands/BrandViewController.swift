//
//  BrandViewController.swift
//  MVVMC
//
//  Created by Dennis Merli on 12/1/17.
//  Copyright © 2017 Dennis Merli. All rights reserved.
//

import UIKit

class BrandViewController: BaseViewController<BrandViewModel>, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    
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

        if let imageURL = brand?.brandImageURL {
            UIImage.loadImageFromURL(imageURL) { (resultImage) in
                guard let resultImage = resultImage else {
                    return
                }
                cell.imgBrand.image = resultImage
            }
        }
        return cell
    }

}



extension BrandViewController : BrandViewModelType {
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

