//
//  ViewController.swift
//  FacebookNewsFeed
//
//  Created by Qichen Huang on 2017-12-14.
//  Copyright © 2017 Qichen Huang. All rights reserved.
//

import UIKit

class FeedController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Facebook Feed"
        
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
    }

}

