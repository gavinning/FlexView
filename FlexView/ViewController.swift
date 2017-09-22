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
        flex.backgroundColor = .gray
        
        flex.isDirectionalLockEnabled = true

        ["001", "002", "003", "004", "005", "006", "007", "008", "009"].forEach { name in
            let img = UIImageView(name: name, width: flex.frame.width)
            flex.addSubview(img!)
        }
        
        flex.spacing = 10
        flex.axis = .vertical
        
        flex.contentSize.height = max(flex.usedSpace.y, view.frame.height)
        flex.contentSize.width = max(flex.usedSpace.x, view.frame.width)
        
        view.addSubview(flex)
    }
}

