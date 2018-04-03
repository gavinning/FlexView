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
        let imgs = ["001", "002", "003", "004", "008", "005", "006", "007", "009", "010", "011", "012", "013", "016", "014", "017", "015", "018", "019", "020"]
        
        flex.axis = .horizontal
        flex.backgroundColor = UIColor.init(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        
        flex.isDirectionalLockEnabled = true
        
        imgs.forEach { (name) in
            let imgButton = UIButton()
            imgButton.setImage(UIImage(named: name), for: .normal)
            imgButton.sizeToFit()
            imgButton.frame.size.height = flex.frame.width/imgButton.frame.width*imgButton.frame.size.height
            imgButton.frame.size.width = flex.frame.width
            
            imgButton.addTarget(self, action: #selector(imageClicked(_:)), for: .touchUpInside)
            
            flex.addSubview(imgButton)
        }

        
        flex.spacing = 16
        flex.axis = .vertical
        
        flex.contentSize.height = max(flex.usedSpace.height, view.frame.height)
        flex.contentSize.width = max(flex.usedSpace.width, view.frame.width)
        
        view.addSubview(flex)
    }
    
    @objc func imageClicked(_ sender: UIImageView) {
        // 点击删除
        if let superview = sender.superview as? FlexView {
            superview.removeSubview(sender, animated: true)
            superview.contentSizeToFit(animated: true)
        }
        
//        // 点击改变子视图大小
//        if let superview = sender.superview as? FlexView {
//            UIView.animate(withDuration: 0.4) {
//                sender.frame.size.height = sender.frame.size.height/2
//                superview.contentSizeToFit()
//            }
//        }
    }
}

