//
//  NSObjectConfig.swift
//  范型使用
//
//  Created by JQ on 2017/10/13.
//  Copyright © 2017年 Majq. All rights reserved.
//

import Foundation
import Foundation.NSObject


//MARK: - 1、定义范型 类型 struct，并实现协议 NSObjectCommonProtocol
public protocol NSObjectCommonProtocol {
    associatedtype U
    var base: U { get }
    init(_ base: U)
}

public struct MajqCommon<V>: NSObjectCommonProtocol {
    public let base: V
    public init(_ base: V) {
        self.base = base
    }
}

//MARK: - 2、定义一个协议（NSObjectCompatible）并实现
///此协议限使用 class 类型实现
public protocol NSObjectCompatible {
    associatedtype  CompatibleType
    
    var fs: MajqCommon<CompatibleType> {get set}
}

public extension NSObjectCompatible {
    public var fs: MajqCommon<Self> {
        get{
            //print(type(of: MajqCommon(self))) //MajqCommon<XXX>  //XXX 表示调用者的类
            
            //此处返回一个 MajqCommon<Self> 实例对象
            //MajqCommon(self) 会调用MajqCommon 里面的init 方法
            //从而返回 调用者本身对象
            //print(type(of: Self.self))
            
            return MajqCommon(self)
        }
        
        set {
            
        }
    }
}

//MARK: - 3、NSObject类实现这个协议（任何一个NSObject 类都可以含有属性 fs）
///已默认 NSObject 类及其子类实现，需要添加其他的方法使用 where 匹配模式扩展
///  例如： UIViewExtension.swift 文件中的 第一个方法
extension NSObject: NSObjectCompatible {
}

/** 用法：
 优点： 使用一个闭包，把调用者本身的属性设置放到一个闭包中执行
 
 let v1 = UIView()
 v1.fs.applyAppearance { (v) in
     v.backgroundColor = UIColor.orange
     v.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
 }
 view.addSubview(v1)

  v1.fs  的返回值类型为 // MajqCommon<UIView>
  v1.fs.base 的返回值类型为 //UIView ,调用者本身的类型
 */





