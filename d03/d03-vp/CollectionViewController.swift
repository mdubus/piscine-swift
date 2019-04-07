//
//  CollectionViewController.swift
//  d03-vp
//
//  Created by Morgane DUBUS on 3/21/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import Foundation
import UIKit

let queue = DispatchQueue.global(qos: DispatchQoS.background.qosClass)

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Return number of cells
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesURL.count
    }
    
    // Populate Cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! CollectionViewCell
        cell.imageLink = imagesURL[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "displayBigImage" {
            guard let dest = segue.destination as? ImageViewController,
                let cell = sender as? CollectionViewCell,
                cell.imageView.image != nil else {return}
            dest.image = cell.imageView.image
        }
    }
    
    /* DESIGN */
    
    
    let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    
    // Disposition of the pictures
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let availableHeight = view.frame.height - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        let heightPerItem = availableHeight / 5
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    // Return inset for section
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // Return spacing for section
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    
}
