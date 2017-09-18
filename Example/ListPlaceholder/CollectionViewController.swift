//
//  CollectionViewController.swift
//  Example
//
//  Created by Moayad Al kouz on 9/18/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import ListPlaceholder
class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "UICollectionView Sample"
        
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        
        self.collectionView.showLoader()
        
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(CollectionViewController.removeLoader), userInfo: nil, repeats: false)
        // Do any additional setup after loading the view.
    }
    

    @objc func removeLoader()
    {
        self.collectionView.hideLoader()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColCell", for: indexPath)
        
        return cell
    }
}
