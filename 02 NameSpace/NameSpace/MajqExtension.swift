//
//  MajqExtension.swift
//  NameSpace
//
//  Created by apple on 2018/5/23.
//  Copyright © 2018年 春风十里. All rights reserved.
//

import Foundation

//MARK: - 测试
// 定义一个protocol -> NamespaceWrappable,含有关联属性： hand【关联类型(HandWrapperType)】
public protocol MajqNamespaceProtocal {
    
    //关联类型
    associatedtype HandWrapperType
    
    //关联属性: 实例属性
    var majq: HandWrapperType { get }
    
    //关联属性： 类 属性
    static var majq: HandWrapperType.Type { get }
    
}

//扩展协议 NamespaceWrappable
public extension MajqNamespaceProtocal {
    //实现协议： 属性majq类型为：MajqNamespaceStruct<Self>，get 方法 返回NamespaceWrapper<Self> 实例对象
    var majq: MajqNamespaceStruct<Self> {
        return MajqNamespaceStruct(value: self)
    }

    //类方法
    static var majq: MajqNamespaceStruct<Self>.Type {
        return MajqNamespaceStruct.self
    }
}


//结构体：NamespaceWrapper【结构体能用于 范型 类型】
public struct MajqNamespaceStruct<T> {
    
    //属性：wrappedValue 类型为范型T
    public let wrappedValue: T
    
    //初始化方法，参数类型为范型T
    public init(value: T) {
        self.wrappedValue = value
    }
}


//用法

//String 实现这个MajqNamespaceProtocal协议
extension String: MajqNamespaceProtocal { }

//为 String拓展一个方法
extension MajqNamespaceStruct where T == String {
    var test: String {
        return wrappedValue
    }
    
}
