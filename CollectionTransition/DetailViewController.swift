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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageToPresent.image = image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
