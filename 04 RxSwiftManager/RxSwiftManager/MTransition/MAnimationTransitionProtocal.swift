//
//  MAnimationTransitionProtocal.swift
//  RxSwiftManager
//
//  Created by Majq on 2018/9/20.
//  Copyright © 2018年 Majq. All rights reserved.
//

import Foundation

class MAnimationTransitionProtocal:NSObject
{
    var mAnimationTransition: MAnimationTransition?
}

extension MAnimationTransitionProtocal:UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let obj = mAnimationTransition else { return nil }
        
        return obj
    }
}
