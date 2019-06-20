//
//  MAnimationTransition.swift
//  RxSwiftManager
//
//  Created by Majq on 2018/9/20.
//  Copyright © 2018年 Majq. All rights reserved.
//  https://www.jianshu.com/p/e7155f938e59

import Foundation

// MARK: - 设置动画类型
/// 动画的类型
///
/// - scale: 放缩
/// - flip: 轻弹
/// - wind: 风
enum MAnimationTransitionType {
    case scale
    case flip
    case wind
}

extension MAnimationTransitionType: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .scale:
            return ""
        case .flip:
            return ""
        case .wind:
            return ""
        }
    }
}


// MARK: - 设置动画
class MAnimationTransition:NSObject {
    
    var type: MAnimationTransitionType = .scale
    private var totalCount: Int = 0
    private var finishedCounter: Int = 0
    
    init(showType: MAnimationTransitionType) {
        self.type = showType
    }
}



extension MAnimationTransition: UIViewControllerAnimatedTransitioning
{
    //动画的执行时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    //处理具体的动画
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch self.type {
        case .scale:
            animateScaleTransition(using: transitionContext)
        case .flip:
            animateFlipTransition(using: transitionContext)
        case .wind:
            animateWindTransition(using: transitionContext)
        }
    }  
}

extension MAnimationTransition {
    private func animateScaleTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let tuple = animateTransitionView(using: transitionContext)
        
        let toView = tuple.0
        let fromView = tuple.1
        let containerView = tuple.2
        
        //转场执行的时候，containerView中只包含fromView，转场动画执行完毕之后，containerView会将fromView移除。
        //因为containerView不负责toView的添加，所以我们需要主动将toView添加到containerView中。
        guard let t = toView else { return  }
        containerView.addSubview(t)
        
        guard let f = fromView else { return  }
        containerView.bringSubview(toFront: f)
        
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            f.alpha = 0
            f.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            t.alpha = 1
            
        }) { (finished) in
            f.transform = CGAffineTransform(scaleX: 1, y: 1)
            
            //上报动画执行完毕[如果动画被取消，传NO]
            transitionContext.completeTransition(true)
            print("------------endAnimation------------")
            for v in containerView.subviews {
                print("v = \(v)")
            }
            
        }
    }
    
    private func animateFlipTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let tuple = animateTransitionView(using: transitionContext)
        
        let toView = tuple.0
        let fromView = tuple.1
        let containerView = tuple.2
        
        guard let t = toView else { return  }
        containerView.addSubview(t)
        containerView.sendSubview(toBack: t)
        
        finishedCounter = 0
        totalCount = 0
        

        
    }
    
    private func animateWindTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let tuple = animateTransitionView(using: transitionContext)
        
//        let toView = tuple.0
//        let fromView = tuple.1
//        let containerView = tuple.2
    }
    
    
    
    private func animateTransitionView(using transitionContext: UIViewControllerContextTransitioning) -> (UIView?,UIView?,UIView){
        
        //根据key返回一个ViewController。
        //我们通过UITransitionContextFromViewControllerKey找到将被替换掉的ViewController，
        //通过UITransitionContextToViewControllerKey找到将要显示的ViewController
        let _ = transitionContext.viewController(forKey: .to)
        let _ = transitionContext.viewController(forKey: .from)
        
        //转场动画发生在该View中
        let containerView = transitionContext.containerView
        
        let toView = transitionContext.view(forKey: .to)
        let fromView = transitionContext.view(forKey: .from)
        
        print("------------startAnimation------------")
        print("fromView = \(String(describing: fromView))")
        print("toView = \(String(describing: toView))")
        print("")
        for v in containerView.subviews {
            print("v = \(v)")
        }
        print("")
        
        return (toView,fromView,containerView)
    }
    
    private func setTransForm3DOfAngle(angle:CGFloat) -> CATransform3D {
        var transform: CATransform3D = CATransform3DIdentity
        transform.m34 = -0.002
        transform = CATransform3DRotate(transform, angle, 0, 1, 0)
        return transform
    }
    
    private func setFlip(view v: UIView,transitionContext: UIViewControllerContextTransitioning) {
        let margin: CGFloat = 1
        v.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        let frame: CGRect = v.layer.frame
        let x = frame.origin.x - frame.size.width * 0.5 + margin
        let y = frame.origin.y + margin
        let w = frame.size.width - margin * 2
        let h = frame.size.height - margin * 2
        v.layer.frame = CGRect(x: x, y: y, width: w, height: h)
        
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            let angle: Double = -Double.pi/2
            v.layer.transform = self.setTransForm3DOfAngle(angle: CGFloat(angle))
        }) { (finished) in
            v.removeFromSuperview()
            
            self.finishedCounter += 1
            if self.finishedCounter == self.totalCount {
               transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}

