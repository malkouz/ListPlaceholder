//
//  ViewController.swift
//  Example
//
//  Created by Moayad Al kouz on 9/26/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import ListPlaceholder

class ViewController: UIViewController {

    @IBOutlet weak var loaderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello Pull request")
        print("Hello Pull request")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showLoader()
    }
    
    
    @IBAction func showLoader(){
        loaderView.showLoader()
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(ViewController.removeLoader), userInfo: nil, repeats: false)
    }
    
    @objc func removeLoader(){
        loaderView.hideLoader()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
