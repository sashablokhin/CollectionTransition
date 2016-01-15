//
//  DetailViewController.swift
//  CollectionTransition
//
//  Created by Alexander Blokhin on 13.01.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageToPresent: UIImageView!
    
    var image: UIImage!
    
    @IBAction func closeButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageToPresent.image = image
        //imageToPresent.backgroundColor = UIColor.blackColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
