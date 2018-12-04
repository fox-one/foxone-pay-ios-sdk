//
//  ViewController.swift
//  SDKDemo
//
//  Created by moubuns on 2018/9/3.
//  Copyright © 2018 FoxOne. All rights reserved.
//

import UIKit
import FoxOnePaySDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PaySDKService.getAssets { completion in
            switch completion {
            case .success(let assets):
                print(assets)
            case .failure(let error):
                print(error)
                break
            }
        }
        
        PaySDKService.getUser { (completion) in
            switch completion {
            case .success(let user):
                print(user)
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}

