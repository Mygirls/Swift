//
//  FifteenthViewController.swift
//  RxSwiftManager
//
//  Created by Majq on 2018/9/18.
//  Copyright © 2018年 Majq. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class FifteenthViewController: UIViewController {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.
        
        //debug_01()
        
        //debug_02()
        
        resourcesTotal()
    }
}

extension FifteenthViewController
{
    
    /// 我们可以将 debug 调试操作符添加到一个链式步骤当中，这样系统就能将所有的订阅者、事件、和处理等详细信息打印出来，方便我们开发调试。
    func debug_01() {
        Observable.of("2", "3")
            .startWith("1")
            .debug()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        /**
         2018-09-18 16:00:15.714: FifteenthViewController.swift:33 (debug_01()) -> subscribed
         2018-09-18 16:00:15.718: FifteenthViewController.swift:33 (debug_01()) -> Event next(1)
         1
         2018-09-18 16:00:15.719: FifteenthViewController.swift:33 (debug_01()) -> Event next(2)
         2
         2018-09-18 16:00:15.719: FifteenthViewController.swift:33 (debug_01()) -> Event next(3)
         3
         2018-09-18 16:00:15.719: FifteenthViewController.swift:33 (debug_01()) -> Event completed
         2018-09-18 16:00:15.719: FifteenthViewController.swift:33 (debug_01()) -> isDisposed

         */
    }
    
    
    /// （3）debug() 方法还可以传入标记参数，这样当项目中存在多个 debug 时可以很方便地区分出来。
    func debug_02() {
        Observable.of("2", "3")
            .startWith("1")
            .debug("调试1")
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        /**
         2018-09-18 16:01:56.306: 调试1 -> subscribed
         2018-09-18 16:01:56.308: 调试1 -> Event next(1)
         1
         2018-09-18 16:01:56.308: 调试1 -> Event next(2)
         2
         2018-09-18 16:01:56.309: 调试1 -> Event next(3)
         3
         2018-09-18 16:01:56.309: 调试1 -> Event completed
         2018-09-18 16:01:56.309: 调试1 -> isDisposed
         */
    }
    
    
    /// 通过将 RxSwift.Resources.total 打印出来，我们可以查看当前 RxSwift 申请的所有资源数量。这个在检查内存泄露的时候非常有用。
    func resourcesTotal() {
//        print(RxSwift.Resources.total)
//        
//        let disposeBag = DisposeBag()
//        
//        print(RxSwift.Resources.total)
//        
//        Observable.of("BBB", "CCC")
//            .startWith("AAA")
//            .subscribe(onNext: { print($0) })
//            .disposed(by: disposeBag)
//        
//        print(RxSwift.Resources.total)
        
    }
}
