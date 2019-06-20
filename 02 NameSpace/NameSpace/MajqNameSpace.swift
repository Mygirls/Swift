//
//  MajqNameSpace.swift
//  NameSpace
//
//  Created by apple on 2018/5/22.
//  Copyright © 2018年 春风十里. All rights reserved.
//

import Foundation

// 定义一个protocol -> NamespaceWrappable,含有关联属性： hand【关联类型(HandWrapperType)】
public protocol NamespaceWrappable {
    
    //关联类型
    associatedtype HandWrapperType
    
    //关联属性
    var hand: HandWrapperType { get }
    
    //关联属性
    static var hand: HandWrapperType.Type { get }
}

//扩展协议 NamespaceWrappable
public extension NamespaceWrappable {
    
    //实现协议： 属性hand类型为：NamespaceWrapper<Self>，get 方法 返回NamespaceWrapper<Self> 实例对象
    var hand: NamespaceWrapper<Self> {
        return NamespaceWrapper(value: self)
    }

    //类方法
    static var hand: NamespaceWrapper<Self>.Type {
        return NamespaceWrapper.self
    }
    

}


//结构体：NamespaceWrapper【结构体能用于 范型 类型】
public struct NamespaceWrapper<T> {
    
    //属性：wrappedValue 类型为范型T
    public let wrappedValue: T
    
    //初始化方法，参数类型为范型T
    public init(value: T) {
        self.wrappedValue = value
    }
}









