//
//  UIViewExtension.swift
//  范型使用
//
//  Created by JQ on 2017/10/13.
//  Copyright © 2017年 Majq. All rights reserved.
//

import Foundation
import UIKit.UIView

//MARK: - 1、extension applyAppearance方法
public extension NSObjectCommonProtocol where U: UIView {
    
    /// 默认的 UI 控件外形设置通用方法
    ///
    /// - Parameter setting: 一个包含外形设置代码的闭包
    ///  - Parameter v: UIView 自身实例
    @discardableResult
    public func applyAppearance(_ settings: (_ v: U) -> Void) -> U {
        settings(base)  //base 是协议 NSObjectCommonProtocol 本身的属性，可以直接使用
        return base
    }
}

//MARK: - 2、extension 一些set、get方法
extension UIView {
    
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set(value) {
            var frame:CGRect =  self.frame
            frame.origin.x = x
            self.frame = frame
        }
    }
    
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set(value) {
            var frame:CGRect =  self.frame
            frame.origin.y = y
            self.frame = frame
        }
    }
    
    
    public var left: CGFloat {
        get {
            return self.frame.origin.x
        }
        set(value) {
            var frame:CGRect =  self.frame
            frame.origin.x = x
            self.frame = frame
        }
    }
    
    public func leftAdd(_ add:CGFloat) {
        var frame:CGRect =  self.frame
        frame.origin.x += add
        self.frame = frame
        
    }
    
    public var top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set(value) {
            var frame:CGRect =  self.frame
            frame.origin.y = y
            self.frame = frame
        }
    }
    
    public func topAdd(_ add:CGFloat) {
        var frame:CGRect =  self.frame
        frame.origin.y += add
        self.frame = frame
        
    }
    
    public var right: CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        } set(value) {
            var frame:CGRect =  self.frame
            frame.origin.x = right - frame.size.width
            self.frame = frame
        }
    }
    
    public var bottom: CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        } set(value) {
            var frame:CGRect =  self.frame
            frame.origin.y = bottom - frame.size.height
            self.frame = frame
        }
    }
    
    public var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set(value) {
            var frame:CGRect =  self.frame
            frame.size.width = width
            self.frame = frame
        }
    }
    
    
    public func widthAdd(_ add:CGFloat) {
        var frame:CGRect =  self.frame
        frame.size.width += add
        self.frame = frame
        
    }
    
    public var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set(value) {
            var frame:CGRect =  self.frame
            frame.size.height = height
            self.frame = frame
        }
    }
    
    
    public func heightAdd(_ add:CGFloat) {
        var frame:CGRect =  self.frame
        frame.size.height += add
        self.frame = frame
        
    }
    
    public var origin: CGPoint {
        get {
            return self.frame.origin
        }
        set(value) {
            var frame:CGRect =  self.frame
            frame.origin = origin
            self.frame = frame
        }
    }
    
    public var size: CGSize {
        get {
            return self.frame.size
        }
        set(value) {
            var frame:CGRect =  self.frame
            frame.size = size
            self.frame = frame
        }
    }
    
}
