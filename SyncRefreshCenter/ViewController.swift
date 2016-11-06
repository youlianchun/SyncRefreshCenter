//
//  ViewController.swift
//  SyncRefreshCenter
//
//  Created by YLCHUN on 16/11/4.
//  Copyright © 2016年 ylchun. All rights reserved.
//

import UIKit

class ViewController: UIViewController,SyncRefreshProtocol {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        syncRefreshMount(obj: self, key: "11")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func syncRefreshEvent(name: String?, object: AnyObject?) {
       print("syncRefreshEvent\(name)\(object)")
    }

    @IBAction func butAction(_ sender: UIButton) {
        SyncRefreshCenter.postEvent(cls: self.classForCoder, key: "11", name: "22")
        SyncRefreshCenter.postUnMountEvent(cls: nil, key: nil)
    }
}

