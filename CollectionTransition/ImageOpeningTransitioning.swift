//
//  ImageOpeningTransitioning.swift
//  CollectionTransition
//
//  Created by Alexander Blokhin on 13.01.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit

class ImageOpeningTransitioning: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    private var presenting = false
    
    // MARK: - UIViewControllerAnimatedTransitioning
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }

    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let sourceViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ViewController
        let targetViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let containerView = transitionContext.containerView()
        let animationDuration = transitionDuration(transitionContext)
        
        let selectedIndexPath = sourceViewController.collectionView.indexPathsForSelectedItems()?.first
        let selectedCell = sourceViewController.collectionView.cellForItemAtIndexPath(selectedIndexPath!) as! ImageCollectionViewCell
        
        let selectedImage = selectedCell.imageView.image
        
        /////
        
        let selectedCellsFrame = containerView?.convertRect(selectedCell.imageView.frame, fromView: selectedCell.imageView.superview)
        
        let selectedImageSnapshot = selectedCell.imageView.snapshotViewAfterScreenUpdates(true)
        selectedImageSnapshot.frame = selectedCellsFrame!
        
        containerView?.addSubview(selectedImageSnapshot)
        
        let whiteBackgroundView = UIView(frame: sourceViewController.view.frame)
        whiteBackgroundView.backgroundColor = UIColor.whiteColor()
        containerView?.insertSubview(whiteBackgroundView, belowSubview: selectedImageSnapshot)

        /////
        
        //CGRect imageViewFinalFrame = [containerView convertRect:CGRectMake(0.0, 0.0, CGRectGetWidth(targetViewController.view.frame), CGRectGetHeight(targetViewController.view.frame)) fromView:targetViewController.view];

    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    

    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }

}
