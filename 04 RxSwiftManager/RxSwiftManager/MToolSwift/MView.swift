//
//  MView.swift
//  RxSwiftManager
//
//  Created by Majq on 2018/9/20.
//  Copyright © 2018年 Majq. All rights reserved.
//

import Foundation

// MARK: - UIView拓展方法
extension MajqNamespaceStruct where T == UIView {
    
    /// 切圆角
    ///
    /// - Parameters:
    ///   - rect: CGRect
    ///   - corners: 圆角的部位
    ///   - cornerRadii: 圆角的Size
    func shapeLayer(roundedRect rect: CGRect, byRoundingCorners corners: UIRectCorner, cornerRadii: CGSize) {
        //画一个部分圆角的矩形 rect: 需要画的矩形的Frame corners: 哪些部位需要画成圆角 cornerRadii: 圆角的Size
        let maskPath = UIBezierPath(roundedRect: wrappedValue.bounds, byRoundingCorners: .allCorners, cornerRadii: wrappedValue.bounds.size)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = wrappedValue.bounds
        maskLayer.path = maskPath.cgPath
        wrappedValue.layer.mask = maskLayer
    }
    
    
    
    
}
