//
//  FlexView.swift
//  FlexView
//
//  Created by gavinning on 2017/9/21.
//  Copyright © 2017年 gavinning. All rights reserved.
//
//  Description 内部UIView自动排列
//
//  @usedSpace: CGPoint {get} 记录子视图在x,y轴的空间占用
//  @axis: Axis {get set} 描述子视图排列方式，默认为垂直排列
//  @spacing: CGFloat {get set} 描述子视图之间间距
//

import UIKit

public class FlexView: UIScrollView {

    // 子视图排列方式
    public enum Axis {
        case vertical   // 垂直对齐 默认
        case horizontal // 水平对齐
    }
    
    // TODO 子视图对齐方式
    private enum Alignment {
        case left   // axis.vertical only
        case right  // axis.vertical only
        case center // also
        case top    // axis.horizontal only
        case bottom // axis.horizontal only
    }
    
    // item减少时重新计算矩阵所占空间
    public enum Resize {
        case both
        case width
        case height
    }
    
    // 记录子视图占用的空间
    public var usedSpace: CGSize {
        // 垂直分布
        if axis == .vertical, frames.count > 0 {
            // x: 最宽子视图的宽度
            // y: 所有子视图高度之和 + 所有子视图之间的间距
            return CGSize(width: widestView!.frame.width, height: CGFloat(frames.count-1) * spacing + sumHeight)
        }
        // 水平分布
        if axis == .horizontal, frames.count > 0 {
            // x: 所有子视图宽度之和 + 所有子视图之间的间距
            // y: 最高子视图的高度
            return CGSize(width: CGFloat(frames.count-1) * spacing + sumWidth, height: highestView!.frame.height)
        }
        return CGSize()
    }
    
    // 子视图排列方向
    public var axis: Axis = .vertical {
        didSet {
            autoLayout()
        }
    }
    
    // 子视图之间间隔
    public var spacing: CGFloat = 0 {
        didSet {
            if spacing < 0 {
                spacing = 0
            }
            autoSpace(oldSpacing: oldValue)
        }
    }
    
    // 缓存所有子视图初始frame信息
    // 因为子视图自动排列的过程中会改变子视图frame
    // 所以需要缓存初始frame信息，在axis属性改变的时候用于重新计算
    private var frames: Dictionary<UIView, CGRect> = [:]
    
    // 子视图中宽度最大的UIView
    private var widestView: UIView? {
        let res = frames.sorted { (a, b) -> Bool in
            return a.key.frame.size.width > b.key.frame.size.width
        }
        return res.count > 0 ? res[0].key : nil
    }
    
    // 子视图中高度最大的UIView
    private var highestView: UIView? {
        let res = frames.sorted { (a, b) -> Bool in
            return a.key.frame.size.height > b.key.frame.size.height
        }
        return res.count > 0 ? res[0].key : nil
    }
    
    // 所有子视图宽度之和
    private var sumWidth: CGFloat {
        var width: CGFloat = 0
        frames.forEach { (view, frame) in
            // 把子视图原有的X轴偏移量添加到宽度计算中，用于计算空间占用
            width += view.frame.size.width + frame.origin.x
        }
        return width
    }
    
    // 所有子视图高度之和
    private var sumHeight: CGFloat {
        var height: CGFloat = 0
        frames.forEach { (view, frame) in
            // 把子视图原有的Y轴偏移量添加到高度计算中，用于计算空间占用
            height += view.frame.size.height + frame.origin.y
        }
        return height
    }

    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public override func addSubview(_ view: UIView) {
        
        // 已添加过的视图不再重复添加
        guard frames[view] == nil else {
            return
        }
        
        // 不记录隐藏的子视图
        guard view.alpha != 0 else {
            super.addSubview(view)
            return
        }

        // A: 此时usedSpace已更新
        // 缓存子视图初始frame
        frames[view] = view.frame
        
        // 垂直方向 更新y轴偏移量
        // A: 所以这里y轴的偏移量要减去自身的高度
        if axis == .vertical {
            view.frame.origin.y += usedSpace.height - view.frame.size.height - view.frame.origin.y
        }
        
        // 水平方向 更新x轴偏移量
        // A: 所以这里x轴的偏移量要减去自身的宽度
        if axis == .horizontal {
            view.frame.origin.x += usedSpace.width - view.frame.size.width - view.frame.origin.x
        }
        
        super.addSubview(view)
    }
    
    public func removeSubview(_ view: UIView) {

        // 检查是否存在当前view
        guard frames[view] != nil else {
            return
        }
        
        view.removeFromSuperview()
        frames[view] = nil
        self.autoLayout()
    }
    
    public func sizeToFit(by resize: Resize, animated: Bool = false) {
        UIView.animate(withDuration: animated ? 0.4 : 0) {
            switch resize {
            case .both: self.frame.size = self.usedSpace
            case .width: self.frame.size.width = self.usedSpace.width
            case .height: self.frame.size.height = self.usedSpace.height
            }
        }
    }
    
    public func sizeToFit(animated: Bool) {
        switch axis {
        case .vertical: self.sizeToFit(by: .height, animated: animated)
        case .horizontal: self.sizeToFit(by: .width, animated: animated)
        }
    }
    
    public override func sizeToFit() {
        self.sizeToFit(animated: false)
    }
    
    public func contentSizeToFit(by resize: Resize, animated: Bool = false) {
        UIView.animate(withDuration: animated ? 0.5 : 0) {
            switch resize {
            case .both: self.contentSize = self.usedSpace
            case .width: self.contentSize.width = self.usedSpace.width
            case .height: self.contentSize.height = self.usedSpace.height
            }
        }
    }
    
    public func contentSizeToFit(animated: Bool = false) {
        switch axis {
        case .vertical: self.contentSizeToFit(by: .height, animated: animated)
        case .horizontal: self.contentSizeToFit(by: .width, animated: animated)
        }
    }
    
    // 切换axis属性时自动重排
    // 重新计算每个子视图的位置
    func autoLayout() {
        var offset: CGFloat = 0
        
        subviews.forEach { view in
            guard let frame = frames[view], view.alpha != 0 else {
                return
            }
            
            view.frame = frame
            
            // 垂直方向 更新y轴偏移量
            // A: 所以这里y轴的偏移量要减去自身的高度
            if axis == .vertical {
                // 更新子视图位置
                view.frame.origin.y += offset
                // 更新Y轴偏移量
                offset += frame.origin.y
                offset += view.frame.size.height
            }
            
            // 水平方向 更新x轴偏移量
            // A: 所以这里x轴的偏移量要减去自身的宽度
            if axis == .horizontal {
                // 更新子视图位置
                view.frame.origin.x += offset
                // 更新X轴偏移量
                offset += frame.origin.x
                offset += view.frame.size.width
            }
        }
        
        // 重新添加子视图spacing
        autoSpace()
    }

    // 子视图之间添加spacing
    func autoSpace(oldSpacing: CGFloat = 0) {
        // 计算spacing改变的差值
        let diff = spacing - oldSpacing
        if axis == .vertical {
            for (i, view) in self.subviews.enumerated() {
                view.frame.origin.y += diff * CGFloat(i)
            }
        }
        if axis == .horizontal {
            for (i, view) in self.subviews.enumerated() {
                view.frame.origin.x += diff * CGFloat(i)
            }
        }
    }
}
