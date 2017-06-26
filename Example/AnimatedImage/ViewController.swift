//
//  ViewController.swift
//  AnimatedImage
//
//  Created by Tigran Yesayan on 06/26/2017.
//  Copyright (c) 2017 Tigran Yesayan. All rights reserved.
//

import UIKit
import AnimatedImage

private let reuseIdentifier = "cell"

class ViewController: UIViewController {
    fileprivate var dataSource = [URL]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dataSource = Bundle.main.urls(forResourcesWithExtension: nil, subdirectory: "images")!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AnimatedCell
        let animatedImage = AnimatedImage(url: dataSource[indexPath.item])
        cell.animatedView.animatedImage = animatedImage
        return cell 
    }
}

