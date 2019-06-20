//
//  MImageView.swift
//  RxSwiftManager
//
//  Created by Majq on 2018/9/20.
//  Copyright © 2018年 Majq. All rights reserved.
//

import Foundation

// MARK: - UIImageView拓展方法
extension MajqNamespaceStruct where T == UIImageView {
   
    
    /// 给UIImageView 设置圆角
    /// - 注意不能设置backgroundColor，暂时不知道为什么
    /// - Parameters:
    ///   - rect: CGRect
    ///   - cornerRadius: 圆角的大小
    func graphicsCutRoundCorners(roundedRect rect: CGRect, cornerRadius: CGFloat) {
        // 开始对imageView进行画图
        UIGraphicsBeginImageContextWithOptions(wrappedValue.bounds.size, false, 0);
        
        // 实例化一个圆形的路径
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        
        //  进行路劲裁切   后续的绘图都会出现在圆形内  外部的都被干掉
        path.addClip()
        wrappedValue.draw(wrappedValue.bounds)
       
        //  取到结果
        wrappedValue.image = UIGraphicsGetImageFromCurrentImageContext()
        
        // 关闭上下文
        UIGraphicsEndImageContext()
        
    }
}

