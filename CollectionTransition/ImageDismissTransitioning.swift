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
    
    private var lastImageLocation = CGPointZero
    
    private var transitionContext: UIViewControllerContextTransitioning?
    
    private var sourceViewController: DetailViewController?
    private var targetViewController: ViewController?
    
    private var exitPanGesture: UIPanGestureRecognizer!
    
    var detailViewController: DetailViewController! {
        didSet {
            self.exitPanGesture = UIPanGestureRecognizer()
            self.exitPanGesture.addTarget(self, action: "handleOffstagePan:")
            self.detailViewController.view.addGestureRecognizer(self.exitPanGesture)
        }
    }
    
    
    func handleOffstagePan(pan: UIPanGestureRecognizer) {
        // how much distance have we panned in reference to the parent view?
        let translation = pan.translationInView(pan.view!)
        //let velocity = pan.velocityInView(pan.view!)
        
        // do some math to translate this to a percentage based value
        let d =  translation.y / CGRectGetWidth(pan.view!.bounds)
        
        // now lets deal with different states that the gesture recognizer sends
        switch (pan.state) {
            
        case UIGestureRecognizerState.Began:
            // set our interactive flag to true
            lastImageLocation = detailViewController.imageToPresent.center
            
            self.interactive = true
            
            self.detailViewController.dismissViewControllerAnimated(true, completion: nil)
            
            break
            
        case UIGestureRecognizerState.Changed:
            // update progress of the transition
            
            let newCenterPoint = CGPointMake(lastImageLocation.x, lastImageLocation.y + translation.y)
            
            detailViewController.imageToPresent.center = newCenterPoint
            
            let verticalDelta: CGFloat = newCenterPoint.y - lastImageLocation.y
            let alpha = backgroundAlphaForPanningWithVerticalDelta(verticalDelta)
            
            sourceViewController!.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(alpha)
            
            break
            
        default: // .Ended, .Cancelled, .Failed ...
            
            // return flag to false and finish the transition
            self.interactive = false
            
            if abs(d) > 0.3 {
                finishInteractiveTransition()
            } else {
                cancelInteractiveTransition()
            }
        }
    }
    
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.35
    }
    
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    }
    
    
    override func startInteractiveTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        self.transitionContext = transitionContext
        
        sourceViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? DetailViewController
        targetViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? ViewController
        
        transitionContext.containerView()?.addSubview(targetViewController!.view)
        transitionContext.containerView()?.addSubview(sourceViewController!.view)
        
        sourceViewController!.view.backgroundColor = UIColor.blackColor()
    }
    
    
    override func finishInteractiveTransition() {
        
        let containerView = transitionContext!.containerView()
        
        let selectedIndexPath = targetViewController!.collectionView.indexPathsForSelectedItems()?.first
        let selectedCell = targetViewController!.collectionView.cellForItemAtIndexPath(selectedIndexPath!) as! ImageCollectionViewCell
        selectedCell.imageView.alpha = 0.0
        //selectedCell.imageView.transform = CGAffineTransformMakeScale(1 , 1.77)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
            
            self.targetViewController!.collectionView.transform = CGAffineTransformMakeScale(1 , 1)
            
            self.sourceViewController!.view.backgroundColor = UIColor.clearColor()
            self.sourceViewController!.imageToPresent.frame = containerView!.convertRect(selectedCell.imageView.frame, fromView: selectedCell.imageView.superview)
            
            }) { (finished) -> Void in
                self.transitionContext!.completeTransition(true)
                self.sourceViewController!.view.alpha = 0.0
                    
                selectedCell.imageView.alpha = 1.0
                selectedCell.imageView.transform = CGAffineTransformIdentity
        }
    }
    
    
    
    override func cancelInteractiveTransition() {
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
            
            self.sourceViewController!.view.backgroundColor = UIColor.blackColor()
            self.sourceViewController!.imageToPresent.center = self.lastImageLocation
            
            }) { (finished) -> Void in
                self.transitionContext!.completeTransition(false)
        }
    }
    
    
    // MARK: - Supporting functions
    
    func backgroundAlphaForPanningWithVerticalDelta(verticalDelta: CGFloat) -> CGFloat {
        let startingAlpha: CGFloat = 1.0
        let finalAlpha: CGFloat = 0.1
        let totalAvailableAlpha: CGFloat = startingAlpha - finalAlpha
        
        let maximumDelta: CGFloat = CGRectGetHeight(self.transitionContext!.viewForKey(UITransitionContextFromViewKey)!.bounds) / 2.0; // Arbitrary value.
        let deltaAsPercentageOfMaximum: CGFloat = min(abs(verticalDelta) / maximumDelta, 1.0)
        
        return startingAlpha - (deltaAsPercentageOfMaximum * totalAvailableAlpha);
    }
}


























