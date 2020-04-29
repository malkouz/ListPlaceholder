//
//  StackViewController.swift
//  Example
//
//  Created by Chung Tran on 4/29/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class StackViewController: UIViewController {
    @IBOutlet weak var hStackView: UIStackView!
    @IBOutlet weak var vStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hStackView.showLoader()
        vStackView.showLoader()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.hStackView.hideLoader()
            self.vStackView.hideLoader()
        }
        // Do any additional setup after loading the view.
    }

}
