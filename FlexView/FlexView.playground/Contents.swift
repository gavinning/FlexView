//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

class PlayViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        flexview()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func flexview() {
        let rect = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        rect.backgroundColor = .red
        
        view.addSubview(rect)
    }
}

let view = PlayViewController()

PlaygroundPage.current.liveView = view
