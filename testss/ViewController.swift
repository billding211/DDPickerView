//
//  ViewController.swift
//  testss
//
//  Created by dingding on 2017/3/17.
//  Copyright © 2017年 dingding. All rights reserved.
//

import UIKit
import MJExtension
import DDPickerView
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let views = DDCityPickerView.init { (province, ctiy) in
            print(province)
            print(ctiy)
        }

        views.show()
        
        
    }

}

