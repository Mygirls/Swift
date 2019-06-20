//
//  MajqExtension.swift
//  NameSpace
//
//  Created by apple on 2018/5/23.
//  Copyright © 2018年 春风十里. All rights reserved.
//
/**
 *  如需自定义命名空间，只需需修改MajqNamespaceProtocal协议中的关联属性 majq 即可
 */
import Foundation

//MARK: - 仿命名空间
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
    //self指向类自身；Self只能作为函数关键字,范型类型：MajqNamespaceProtocal
    //Self可以用于协议(protocol)中限制相关的类型
    //Self可以用于类(Class)中来充当方法的返回值类型
    //btn.majq 返回值类型为：MajqNamespaceStruct<UIButton> 具体看：https://www.jianshu.com/p/5059d2993509
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


//MARK: - 用法

//NSObject类实现这个协议（任何一个NSObject 类都可以含有属性 majq）
///已默认 NSObject 类及其子类实现，需要添加其他的方法使用 where 匹配模式扩展
///如下面： mcApplyAppearance 方法
extension NSObject: MajqNamespaceProtocal {
    
}

//String 实现这个MajqNamespaceProtocal协议
extension String: MajqNamespaceProtocal {
    
}

//为 String拓展一个方法
extension MajqNamespaceStruct where T == String {
    var majqTest: String {
        return wrappedValue
    }
    
}


//由于 namespace 相当于将原来的值做了封装,所以如果在写扩展方法时需要用到原来的值,就不能再使用self,而应该使用wrappedValue
public extension MajqNamespaceStruct where T: UIView {
    
    /// 默认的 UI 控件外形设置通用方法
    ///
    /// - Parameter settings: 一个包含外形设置代码的闭包: 参数为范型T，返回值Void 
    /// - Returns: UIView自身实例
    @discardableResult
    public func mcApplyAppearance(_ settings: (_ v: T) -> Void) -> T {
        settings(wrappedValue)  //wrappedValue 是协议 MajqNamespaceStruct 本身的属性，可以直接使用
        return wrappedValue
    }
    
    
}
