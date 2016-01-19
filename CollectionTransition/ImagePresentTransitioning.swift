//
//  ImagePresentTransitioning.swift
//  CollectionTransition
//
//  Created by Alexander Blokhin on 14.01.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit


class ImagePresentTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.35
    }
    
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let sourceViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ViewController
        let targetViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! DetailViewController
        
        let containerView = transitionContext.containerView()
        let animationDuration = transitionDuration(transitionContext)
        
        let selectedIndexPath = sourceViewController.collectionView.indexPathsForSelectedItems()?.first
        let selectedCell = sourceViewController.collectionView.cellForItemAtIndexPath(selectedIndexPath!) as! ImageCollectionViewCell
        
        let selectedImage = selectedCell.imageView.image
        
        let selectedCellsFrame = containerView!.convertRect(selectedCell.imageView.frame, fromView: selectedCell.imageView.superview)
        
        let selectedImageWrapperView = UIView(frame: selectedCellsFrame)
        selectedImageWrapperView.backgroundColor = UIColor.clearColor()
        selectedImageWrapperView.clipsToBounds = true
        
        let imageView = UIImageView(image: selectedImage)
        imageView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(selectedCellsFrame), CGRectGetHeight(selectedCellsFrame))
        imageView.contentMode = .ScaleAspectFit
        
        selectedImageWrapperView.addSubview(imageView)
        
        containerView!.addSubview(selectedImageWrapperView)
        
        let blackBackgroundView = UIView(frame: sourceViewController.view.frame)
        blackBackgroundView.backgroundColor = UIColor.blackColor()
        containerView!.insertSubview(blackBackgroundView, belowSubview: selectedImageWrapperView)
        
        blackBackgroundView.alpha = 0
        
        let imageViewFinalFrame = containerView!.convertRect(CGRectMake(0.0, 0.0, CGRectGetWidth(targetViewController.view.frame), CGRectGetHeight(targetViewController.view.frame)), fromView: targetViewController.view)
        
        selectedCell.imageView.alpha = 0.0
        
        UIView.animateWithDuration(animationDuration, animations: { () -> Void in
            selectedImageWrapperView.frame = imageViewFinalFrame
            imageView.frame = imageViewFinalFrame
            
            blackBackgroundView.alpha = 1
            
            }) { (finished) -> Void in
                targetViewController.imageToPresent.image = selectedImage
                
                targetViewController.view.alpha = 1
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
                
                blackBackgroundView.removeFromSuperview()
                
                selectedImageWrapperView.removeFromSuperview()
                UIApplication.sharedApplication().keyWindow?.addSubview(targetViewController.view)
        }
    }
}

    
    
    
    
    
    
    






















