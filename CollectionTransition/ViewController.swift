//
//  ViewController.swift
//  CollectionTransition
//
//  Created by Alexander Blokhin on 11.01.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var customTransitionDelegate = ImageOpeningTransitioning()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.collectionViewLayout = CustomFlowLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UICollectionViewDataSource 
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 36
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ImageCollectionViewCell
        
        let imageName = "img_\(imageIndex(indexPath.row))"
        
        cell.imageView.image = UIImage(named: imageName)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("openDetailView", sender: indexPath)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "openDetailView" {
            let detailViewController = segue.destinationViewController as! DetailViewController
            detailViewController.transitioningDelegate = customTransitionDelegate
            
            customTransitionDelegate.imageDismiss.detailViewController = detailViewController
            
            if let indexPath = sender as? NSIndexPath {
                let imageName = "img_\(imageIndex(indexPath.row))"
                detailViewController.image = UIImage(named: imageName)
            }
        }
    }
    
    
    // MARK: - Supporting functions
    
    func imageIndex(var index: Int) -> Int {
        if index > 5 {
            index -= 6
            
            return imageIndex(index)
        }
        
        return index
    }
}

