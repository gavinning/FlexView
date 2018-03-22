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

```
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