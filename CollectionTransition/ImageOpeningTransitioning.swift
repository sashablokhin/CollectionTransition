//
//  ImageOpeningTransitioning.swift
//  CollectionTransition
//
//  Created by Alexander Blokhin on 13.01.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit

class ImageOpeningTransitioning: NSObject, UIViewControllerTransitioningDelegate {
    
    let imagePresent = ImagePresentTransitioning()
    let imageDismiss = ImageDismissTransitioning()
    
        
    // MARK: - UIViewControllerTransitioningDelegate
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return imagePresent
    }
    

    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return imageDismiss
    }

}
