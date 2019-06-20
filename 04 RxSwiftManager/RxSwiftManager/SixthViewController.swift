//
//  SixthViewController.swift
//  RxSwiftManager
//
//  Created by Majq on 2018/9/10.
//  Copyright © 2018年 Majq. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SixthViewController: UIViewController {

    /**
     前沿：
        从前面的几篇文章可以发现，当我们创建一个 Observable 的时候就要预先将要发出的数据都准备好，等到有人订阅它时再将数据通过 Event 发出去。
        但有时我们希望 Observable 在运行时能动态地“获得”或者说“产生”出一个新的数据，再通过 Event发送出去。比如：订阅一个输入框的输入内容，当用户每输入一个字后，这个输入框关联的 Observable 就会发出一个带有输入内容的 Event，通知给所有订阅者。
        这个就可以使用下面将要介绍的 Subjects 来实现。
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //MARK: - 建议通过断点调试 来理解，查看执行的顺序
        //demo_01()
        
        //demo_02()
        
        //demo_03()
        
        demo_04()
    }

   
    /** Subjects 基本介绍
     1）Subjects 既是订阅者，也是 Observable：
     说它是订阅者，是因为它能够动态地接收新的值。【subject.onNext("111")】
     说它又是一个 Observable，是因为当 Subjects 有了新的值之后，就会通过 Event 将新值发出给他的所有订阅者。【subject.subscribe(onNext: { (value) in】
     2）一共有四种 Subjects，分别：
     PublishSubject、BehaviorSubject、ReplaySubject、Variable
     
     
     相同点：
     首先他们都是 Observable，他们的订阅者都能收到他们发出的新的 Event
     直到 Subject 发出 .complete 或者 .error 的 Event 后，该 Subject 便终结了，同时它也就不会再发出.next事件
     对于那些在 Subject 终结后再订阅他的订阅者，也能收到 subject发出的一条 .complete 或 .error的 event，告诉这个新的订阅者它已经终结了。
     
     
     异：
     他们之间最大的区别只是在于：
     当一个新的订阅者刚订阅它的时候，能不能收到 Subject 以前发出过的旧 Event，如果能的话又能收到多少个。
     */
}


// MARK: -  PublishSubject
extension SixthViewController
{
    /**
     PublishSubject是最普通的 Subject，它不需要初始值就能创建。
     PublishSubject 的订阅者从他们开始订阅的时间点起，可以收到订阅后 Subject 发出的新 Event，而不会收到他们在订阅前已发出的 Event。
     */
    /// PublishSubject
    func demo_01() {
        let disposeBag = DisposeBag()

        //创建一个publishSubject
        let subject = PublishSubject<String>()
        
        //由于当前没有任何订阅者，所以不是输出信息到控制台
        subject.onNext("111")
        
        //第一次订阅subject
        subject.subscribe(onNext: { (string) in
            print("第1次订阅：",string)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("第1次订阅 onCompleted")
        }).disposed(by: disposeBag)
        
        //当前有一个订阅，则该信息会输出到控制台
        subject.onNext("222")
        
        //第2次订阅subject
        subject.subscribe(onNext: { (string) in
            print("第2次订阅：",string)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("第2次订阅 onCompleted")
        }).disposed(by: disposeBag)
        
        //当前有2个订阅，则该信息会输出到控制台
        subject.onNext("333")
        
        //让subject结束
        subject.onCompleted()
        
        //subject完成后会发出.next事件了。
        subject.onNext("444")
        
        //subject完成后它的所有订阅（包括结束后的订阅），都能收到subject的.completed事件，
        subject.subscribe(onNext: { string in
            print("第3次订阅：", string)
        }, onCompleted:{
            print("第3次订阅：onCompleted")
        }).disposed(by: disposeBag)
        
        /**
         第1次订阅： 222
         第1次订阅： 333
         第2次订阅： 333
         第1次订阅 onCompleted
         第2次订阅 onCompleted
         第3次订阅：onCompleted
         */
    }
}

// MARK: - BehaviorSubject
extension SixthViewController
{
    func demo_02() {
        /**
         1）基本介绍
            BehaviorSubject 需要通过一个默认初始值来创建。
            当一个订阅者来订阅它的时候，这个订阅者会立即收到 BehaviorSubjects 上一个发出的event。
            之后就跟正常的情况一样，它也会接收到 BehaviorSubject 之后发出的新的 event。
         */
        let disposeBag = DisposeBag()
        
        //创建一个BehaviorSubject
        let subject = BehaviorSubject(value: "111")
        
        //第1次订阅subject
        subject
            .subscribe { event in
                print("第1次订阅：", event)
            }
            .disposed(by: disposeBag)
        
        //发送next事件
        subject.onNext("222")
        
        //发送error事件
        subject.onError(NSError(domain: "local", code: 0, userInfo: nil))
        
        //第2次订阅subject
        subject
            .subscribe { event in
                print("第2次订阅：", event)
            }
            .disposed(by: disposeBag)
        /**
         第1次订阅： next(111)
         第1次订阅： next(222)
         第1次订阅： error(Error Domain=local Code=0 "(null)")
         第2次订阅： error(Error Domain=local Code=0 "(null)")

         */
        
    }
}


// MARK: - ReplaySubject
extension SixthViewController
{
    /*
     ReplaySubject 在创建时候需要设置一个 bufferSize，表示它对于它发送过的 event 的缓存个数。
     比如一个 ReplaySubject 的 bufferSize 设置为 2，它发出了 3 个 .next 的 event，那么它会将后两个（最近的两个）event 给缓存起来。
     此时如果有一个 subscriber 订阅了这个 ReplaySubject，那么这个 subscriber 就会立即收到前面缓存的两个.next 的 event。
     如果一个 subscriber 订阅已经结束的 ReplaySubject，除了会收到缓存的 .next 的 event外，还会收到那个终结的 .error 或者 .complete 的event。
     
     */
    func demo_03() {
        let disposeBag = DisposeBag()
        
        //创建一个bufferSize为2的ReplaySubject
        let subject = ReplaySubject<String>.create(bufferSize: 2)
        
        //连续发送3个next事件
        subject.onNext("111")
        subject.onNext("222")
        subject.onNext("333")
        
        //第1次订阅subject
        subject
            .subscribe { event in
                print("第1次订阅：", event)
            }
            .disposed(by: disposeBag)
        
        //再发送1个next事件
        subject.onNext("444")
        
        //第2次订阅subject
        subject
            .subscribe { event in
                print("第2次订阅：", event)
            }
            .disposed(by: disposeBag)
        
        //让subject结束
        subject.onCompleted()
        
        //第3次订阅subject
        subject
            .subscribe { event in
                print("第3次订阅：", event)
            }
            .disposed(by: disposeBag)
        /**
         注意：由于 Variable对象在viewDidLoad() 方法内初始化，所以它的生命周期就被限制在该方法内。当这个方法执行完毕后，这个 Variable 对象就会被销毁，同时它也就自动地向它的所有订阅者发出.completed 事件
         
         */
        /**
         第1次订阅： next(222)
         第1次订阅： next(333)
         第1次订阅： next(444)
         第2次订阅： next(333)
         第2次订阅： next(444)
         第1次订阅： completed
         第2次订阅： completed
         第3次订阅： next(333)
         第3次订阅： next(444)
         第3次订阅： completed

         
         */
    }
}


// MARK: - Variable
extension SixthViewController
{
    /**
     Variable 其实就是对 BehaviorSubject 的封装，所以它也必须要通过一个默认的初始值进行创建。
     Variable 具有 BehaviorSubject 的功能，能够向它的订阅者发出上一个 event 以及之后新创建的 event。
    
     不同的是，Variable 还会把当前发出的值保存为自己的状态。同时它会在销毁时自动发送 .complete的 event，不需要也不能手动给 Variables 发送 completed或者 error 事件来结束它。
   
     简单地说就是
        Variable 有一个 value 属性，我们改变这个 value 属性的值就相当于调用一般 Subjects 的 onNext() 方法，
        而这个最新的 onNext() 的值就被保存在 value 属性里了，直到我们再次修改它。
     
    
     */
    /**
     Variables 本身没有 subscribe() 方法，但是所有 Subjects 都有一个 asObservable() 方法。我们可以使用这个方法返回这个 Variable 的 Observable 类型，拿到这个 Observable 类型我们就能订阅它了。
     */
    func demo_04() {
        let disposeBag = DisposeBag()
        
        //创建一个初始值为111的Variable
        let variable = Variable("111")
        
        //修改value值
        variable.value = "222"
        
        //第1次订阅
        variable.asObservable().subscribe {
            print("第1次订阅：", $0)
            }.disposed(by: disposeBag)
        
        //修改value值
        variable.value = "333"
        
        //第2次订阅
        variable.asObservable().subscribe {
            print("第2次订阅：", $0)
            }.disposed(by: disposeBag)
        
        //修改value值
        variable.value = "444"
        
        /**
         第1次订阅： next(222)
         第1次订阅： next(333)
         第2次订阅： next(333)
         第1次订阅： next(444)
         第2次订阅： next(444)
         第1次订阅： completed
         第2次订阅： completed
         
         注意：由于 Variable对象在viewDidLoad() 方法内初始化，所以它的生命周期就被限制在该方法内。当这个方法执行完毕后，这个 Variable 对象就会被销毁，同时它也就自动地向它的所有订阅者发出.completed 事件
         
         **/
    }
}

