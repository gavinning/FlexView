FlexView
---
简单的盒模型，类似HTML的Flexbox，完整功能还在实现中...


```swift
let flex = FlexView(frame: CGRect(x: 0, y: 0, width: 320, height: 568))
let title = UILabel(frame: CGRect(x: 0, y: 0, width: 320, height: 60))
let image = UIImageView(UIImage(named: "001"))

title.text = "这是一个标题"
image.frame.size = CGSize(width: 320, height: 320)

flex.addSubview(title)
flex.addSubview(image)
```

```swift
// 盒子子视图排列方向 默认为垂直排列
flex.axis = .vertical
// 可选水平排列
flex.axis = .horizontal

// 子视图之间间距，默认值为0
// 如果要单独为某个子视图设置间距，直接改变该视图的x,y轴数值即可
flex.spacing = 0

// 盒子空间占用情况，只读属性
flex.usedSpace
```

**删除子视图时更新FlexView** 
```swift

let flex = FlexView()
let btn = UIButton

btn.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)

// This in ViewController
@objc func btnClicked(_ sender: UIButton) {
	if let superview = sender.superview as? FlexView {
		// 使用FlexView的删除方法 removeSubview
		// 不要使用sender.removeFromSuperview()
        superview.removeSubview(sender)
        // 更新contentSize用此方法
        superview.contentSizeToFit(animated: true)
        // 更新size用此方法
        superview.sizeToFit(animated: true)

        // sizeToFit的resize属性默认根据axis的值决定，也可以手动指定
        // 例如 只更新width
        superview.sizeToFit(by: .width)
        // 例如 只更新height
        superview.sizeToFit(by: .height)
        // 例如 宽高全部更新
        superview.sizeToFit(by: .both)
        // contentSizeToFit使用方法同上
    }
}
```