//
//  ImageViewController.swift
//  d03-vp
//
//  Created by Morgane on 22/03/2019.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import Foundation
import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    var image: UIImage?
    var imageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard image != nil else {return }
        imageView = UIImageView(image: image)
        guard imageView != nil else {return }
        
        self.setupViews ()
        setImageSize(screenWidth: self.view.bounds.width);
        scrollView.addSubview(self.imageView!)
    }
    
    func setupViews() {
        self.imageView!.contentMode = .scaleAspectFill;
        self.imageView!.clipsToBounds = true;
        scrollView.isScrollEnabled = true;
        scrollView.maximumZoomScale = 100.0;
        scrollView.minimumZoomScale = 1.0;
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.showsVerticalScrollIndicator = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        setImageSize(screenWidth: size.width);
    }
    
    func setImageSize(screenWidth: CGFloat) {
        let imageFullSize = imageView!.frame.size
        let imageRatio = imageFullSize.height / imageFullSize.width
        self.imageView!.frame = CGRect(
            x: 0,
            y: 0,
            width: screenWidth,
            height: screenWidth * imageRatio
        );
        scrollView.contentSize = imageView!.frame.size;
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}
