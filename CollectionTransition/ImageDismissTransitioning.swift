//
//  ImageDismissTransitioning.swift
//  CollectionTransition
//
//  Created by Alexander Blokhin on 14.01.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit


class ImageDismissTransitioning: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
    
    var interactive = false
    
    private var exitPanGesture: UIPanGestureRecognizer!
    
    var detailViewController: UIViewController! {
        didSet {
            self.exitPanGesture = UIPanGestureRecognizer()
            self.exitPanGesture.addTarget(self, action: "handleOffstagePan:")
            self.detailViewController.view.addGestureRecognizer(self.exitPanGesture)
        }
    }
    
    func handleOffstagePan(pan: UIPanGestureRecognizer) {
        // how much distance have we panned in reference to the parent view?
        let translation = pan.translationInView(pan.view!)
        let velocity = pan.velocityInView(pan.view!)
        
        // do some math to translate this to a percentage based value
        let d =  translation.y / CGRectGetWidth(pan.view!.bounds)
        
        // now lets deal with different states that the gesture recognizer sends
        switch (pan.state) {
            
        case UIGestureRecognizerState.Began:
            // set our interactive flag to true
            self.interactive = true
            
            self.detailViewController.dismissViewControllerAnimated(true, completion: nil)
            break
            
        case UIGestureRecognizerState.Changed:
            
            // update progress of the transition
            
            if velocity.y < 0 {
                self.updateInteractiveTransition(-d)
            } else {
                self.updateInteractiveTransition(d)
            }

            break
            
        default: // .Ended, .Cancelled, .Failed ...
            
            // return flag to false and finish the transition
            self.interactive = false
            
            if abs(d) > 0.4 {
                self.finishInteractiveTransition()
            } else {
                self.cancelInteractiveTransition()
            }
        }
    }
    
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.35
    }
    
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let sourceViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! DetailViewController
        let targetViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! ViewController
        
        let containerView = transitionContext.containerView()
        let animationDuration = transitionDuration(transitionContext)
        
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
        
        containerView!.addSubview(imageWrapperView)
        
        let blackBackgroundView = UIView(frame: sourceViewController.view.frame)
        blackBackgroundView.backgroundColor = UIColor.blackColor()
        containerView!.insertSubview(blackBackgroundView, belowSubview: imageWrapperView)
        
        
        UIView.animateWithDuration(animationDuration, animations: { () -> Void in
            
            blackBackgroundView.alpha = 0.0
            
            imageWrapperView.frame = containerView!.convertRect(selectedCell.imageView.frame, fromView: selectedCell.imageView.superview)
  
            
            }) { (finished) -> Void in
                if !transitionContext.transitionWasCancelled() {
                    transitionContext.completeTransition(true)
                    
                    sourceViewController.view.alpha = 0.0
                    snapshot.alpha = 0.0
                    
                    
                    blackBackgroundView.removeFromSuperview()
                    snapshot.removeFromSuperview()
                    imageWrapperView.removeFromSuperview()
                    sourceViewController.imageToPresent.hidden = false
                    
                    selectedCell.imageView.alpha = 1.0
                    selectedCell.imageView.transform = CGAffineTransformIdentity
                } else {
                    transitionContext.completeTransition(false)
                    
                    sourceViewController.imageToPresent.alpha = 1.0
                }
        }
    }
}
















