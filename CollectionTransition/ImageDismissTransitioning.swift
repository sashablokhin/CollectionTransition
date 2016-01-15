//
//  ImageDismissTransitioning.swift
//  CollectionTransition
//
//  Created by Alexander Blokhin on 14.01.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit


class ImageDismissTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let sourceViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! DetailViewController
        let targetViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! ViewController
        
        let containerView = transitionContext.containerView()
        let animationDuration = transitionDuration(transitionContext)
        
        
        //sourceViewController.imageToPresent.frame.size = CGSize(width: 100, height: 100)
        
        
        let snapshot = sourceViewController.imageToPresent.snapshotViewAfterScreenUpdates(false)
        snapshot.frame = containerView!.convertRect(sourceViewController.imageToPresent.frame, fromView: sourceViewController.imageToPresent.superview)
        
        snapshot.autoresizingMask = [.FlexibleHeight, .FlexibleWidth, .FlexibleTopMargin, .FlexibleBottomMargin]
        
        sourceViewController.imageToPresent.alpha = 0.0
        
        
        // hide the target cell's imageView
        
        let selectedIndexPath = targetViewController.collectionView.indexPathsForSelectedItems()?.first
        let selectedCell = targetViewController.collectionView.cellForItemAtIndexPath(selectedIndexPath!) as! ImageCollectionViewCell
        selectedCell.imageView.alpha = 0.0
        
        selectedCell.imageView.transform = CGAffineTransformMakeScale(1 , 1.77)
        
        
        targetViewController.view.frame = transitionContext.finalFrameForViewController(targetViewController)
        containerView?.insertSubview(targetViewController.view, belowSubview: sourceViewController.view)
        
        let imageWrapperView = UIView(frame: containerView!.convertRect(sourceViewController.imageToPresent.frame, fromView: sourceViewController.imageToPresent.superview))
        
        imageWrapperView.clipsToBounds = true
        
        imageWrapperView.addSubview(snapshot)
        
        containerView?.addSubview(imageWrapperView)
        
        
        let blackBackgroundView = UIView(frame: sourceViewController.view.frame)
        blackBackgroundView.backgroundColor = UIColor.blackColor()
        containerView!.insertSubview(blackBackgroundView, belowSubview: imageWrapperView)
        
        /*
        UIView.animateKeyframesWithDuration(animationDuration, delay: 0.0, options: .CalculationModeLinear, animations: { () -> Void in
            
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 1.0, animations: { () -> Void in
                sourceViewController.view.alpha = 0.0
                imageWrapperView.frame = containerView!.convertRect(selectedCell.imageView.frame, fromView: selectedCell.imageView.superview)
                blackBackgroundView.alpha = 0.0
                
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.95, relativeDuration: 0.05, animations: { () -> Void in
                selectedCell.imageView.transform = CGAffineTransformIdentity
                snapshot.alpha = 0.0
            })
            
            }) { (finished) -> Void in
                blackBackgroundView.removeFromSuperview()
                snapshot.removeFromSuperview()
                imageWrapperView.removeFromSuperview()
                sourceViewController.imageToPresent.hidden = false
                
                selectedCell.imageView.alpha = 1.0
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }*/
        
        
        UIView.animateWithDuration(animationDuration, animations: { () -> Void in
            
            
            
 //           sourceViewController.view.alpha = 0.0
            //imageWrapperView.frame = containerView!.convertRect(selectedCell.imageView.frame, fromView: selectedCell.imageView.superview)
            
            blackBackgroundView.alpha = 0.0
            
            //selectedCell.imageView.transform = CGAffineTransformIdentity
            //snapshot.alpha = 0.0
            
            
            imageWrapperView.frame = containerView!.convertRect(selectedCell.imageView.frame, fromView: selectedCell.imageView.superview)

            
            
            /*
            let newWidth = CGRectGetWidth(targetViewController.view.frame)
            let scale = newWidth / CGRectGetWidth(imageWrapperView.frame)
            let newHeight = CGRectGetHeight(imageWrapperView.frame) * -scale
            
            
            //let imageViewFinalFrame = CGRectMake(0.0, 0.0, newWidth, newHeight)
            
            imageWrapperView.frame = CGRectMake(0.0, 0.0, newWidth, newHeight)*/
            
            
            selectedCell.imageView.transform = CGAffineTransformIdentity
            
            
            
            
            }) { (finished) -> Void in
                
                sourceViewController.view.alpha = 0.0
                snapshot.alpha = 0.0
                
                
                blackBackgroundView.removeFromSuperview()
                snapshot.removeFromSuperview()
                imageWrapperView.removeFromSuperview()
                sourceViewController.imageToPresent.hidden = false
                
                selectedCell.imageView.alpha = 1.0
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
                
                
                
                
                //selectedCell.imageView.transform = CGAffineTransformIdentity
        }
        
    }
}
















