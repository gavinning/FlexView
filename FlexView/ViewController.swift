//
//  ViewController.swift
//  FlexView
//
//  Created by gavinning on 2017/9/21.
//  Copyright © 2017年 gavinning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        flexview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func flexview() {
        let flex = FlexView(frame: view.frame)
        
        flex.axis = .horizontal
        flex.backgroundColor = UIColor.init(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        
        flex.isDirectionalLockEnabled = true

        ["001", "002", "003", "004", "008", "005", "006", "007", "009", "010", "011", "012", "013", "016", "014", "017", "015", "018", "019", "020"].forEach { name in
            let img = UIImageView(name: name, width: flex.frame.width)
            // img?.frame.origin.x = 20
            flex.addSubview(img!)
        }
        
        flex.spacing = 16
        flex.axis = .vertical
        
        flex.contentSize.height = max(flex.usedSpace.y, view.frame.height)
        flex.contentSize.width = max(flex.usedSpace.x, view.frame.width)
        
        view.addSubview(flex)
    }
}

