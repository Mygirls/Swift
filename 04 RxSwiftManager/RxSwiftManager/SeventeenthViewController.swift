//
//  SeventeenthViewController.swift
//  RxSwiftManager
//
//  Created by Majq on 2018/9/18.
//  Copyright © 2018年 Majq. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SeventeenthViewController: UIViewController {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        driver_01()
    }
}

// MARK: - Driver
extension SeventeenthViewController
{
    /**
     1，基本介绍
     
     （1）Driver 可以说是最复杂的 trait，它的目标是提供一种简便的方式在 UI 层编写响应式代码。
     
     （2）如果我们的序列满足如下特征，就可以使用它：
     
     不会产生 error 事件
     一定在主线程监听（MainScheduler）
     共享状态变化（shareReplayLatestWhileConnected）
     2，为什么要使用 Driver?
     
     （1）Driver 最常使用的场景应该就是需要用序列来驱动应用程序的情况了，比如：
     
     通过 CoreData 模型驱动 UI
     使用一个 UI 元素值（绑定）来驱动另一个 UI 元素值
     （2）与普通的操作系统驱动程序一样，如果出现序列错误，应用程序将停止响应用户输入。
     
     （3）在主线程上观察到这些元素也是极其重要的，因为 UI 元素和应用程序逻辑通常不是线程安全的。
     
     （4）此外，使用构建 Driver 的可观察的序列，它是共享状态变化。
     
     3，使用样例
     
     这个是官方提供的样例，大致的意思是根据一个输入框的关键字，来请求数据，然后将获取到的结果绑定到另一个 Label 和 TableView 中。
     
     （1）初学者使用 Observable 序列加 bindTo 绑定来实现这个功能的话可能会这么写：
     */
    
    func driver_01() {
        let observer = Observable<Any>.create { (observer) -> Disposable in
            observer.onNext("next")
            observer.onError(LJError.faild)
            //observer.onCompleted()
            
            return Disposables.create()
        }
        
        observer.asDriver(onErrorJustReturn: "driver error")
            .drive(onNext: { (next) in
                print("driver onNext: \(next)")
            }, onCompleted: {
                print("driver onCompleted")
            }, onDisposed: {
                print("driver onDisposed")
            })
            .disposed(by: disposeBag)
        
        /**
         driver onNext: next
         driver onNext: driver error
         driver onCompleted
         driver onDisposed
         
         结论
         
         我们可以发现：
         
         observer.onNext() 可以触发 drive(onNext: {})
         observer.onError() 也可触发 drive(onNext: {}), 但是返回的不是error信息，是onErrorJustReturn的值
         observer.onError() 和 observer.onCompleted() 都会触发 .drive(onCompleted:{})
         
         */
        
    }
    
    func driver_02() {
        
    }
    
    
    enum LJError: Error {
        case faild
    }
}
