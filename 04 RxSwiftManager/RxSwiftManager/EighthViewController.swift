//
//  EighthViewController.swift
//  RxSwiftManager
//
//  Created by Majq on 2018/9/10.
//  Copyright © 2018年 Majq. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class EighthViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //filterDemo()
        
        //distinctUntilChangedDemo()
        
        //singleDemo()
        
        //elementAtDemo()
        
        //ignoreElementsDemo()
        
        //takeDemo()
        
        //takeLastDemo()
        
        //skipDemo()
        
        //SampleDemo()
        
        debounceDemo()
    }
}


extension EighthViewController
{
    /**
     该操作符就是用来过滤掉某些不符合要求的事件。
     */
    ///filter
    func filterDemo() {
        Observable.of(2,30,22,5,60,3,40,9)
            .filter { $0 > 10 }
            .subscribe(onNext: {print($0)})
            .disposed(by: disposeBag)
        
        /**
         30
         22
         60
         40
         */
        
    }
    
    /**
     该操作符用于过滤掉连续重复的事件。
     */
    ///distinctUntilChanged
    func distinctUntilChangedDemo() {
        Observable.of(1,2,3,3,4,3,2,2,1)
            .distinctUntilChanged()
            .subscribe(onNext: {print($0)})
            .disposed(by: disposeBag)
        /**
         1
         2
         3
         4
         3
         2
         1
         */
    }
    
    /**
     限制只发送一次事件，或者满足条件的第一个事件。
     如果存在有多个事件或者没有事件都会发出一个 error 事件。
     如果只有一个事件，则不会发出 error事件。
     */
    ///single
    func singleDemo() {
        Observable.of(1,2,3,4)
            .single()
            .subscribe(onNext: {print($0)})
            .disposed(by: disposeBag)
        
        Observable.of("A","B","C","D")
            .single()
            .subscribe(onNext: {print($0)})
            .disposed(by: disposeBag)
        
        /**
         1
         Unhandled error happened: Sequence contains more than one element.
         subscription called from:
         
         A
         Unhandled error happened: Sequence contains more than one element.
         subscription called from:
         */
    }
    
 
    ///elementAt:该方法实现只处理在指定位置的事件。
    func elementAtDemo() {
        Observable.of(1, 2, 3, 4)
            .elementAt(2)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        /**
         3
         */
    }
    
    /**
     
     */
    
    /**
     该操作符可以忽略掉所有的元素，只发出 error或completed 事件。如果我们并不关心 Observable 的任何元素，只想知道 Observable 在什么时候终止，那就可以使用 ignoreElements 操作符。
     */
    ///ignoreElements
    func ignoreElementsDemo() {
        Observable.of(1, 2, 3, 4)
            .ignoreElements()
            .subscribe{
                print($0)
            }
            .disposed(by: disposeBag)
        
        /**
         completed
         */
    }
    
    ///take 该方法实现仅发送 Observable 序列中的前 n 个事件，在满足数量之后会自动 .completed
    func takeDemo() {
        Observable.of(1, 2, 3, 4)
            .take(2)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    

    ///takeLast 该方法实现仅发送 Observable序列中的后 n 个事件。
    func takeLastDemo() {
        Observable.of(1, 2, 3, 4)
            .takeLast(1)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    ///skip 该方法用于跳过源 Observable 序列发出的前 n 个事件。
    func skipDemo() {
        Observable.of(1, 2, 3, 4)
            .skip(2)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    /**
     Sample 除了订阅源Observable 外，还可以监视另外一个 Observable， 即 notifier 。
     每当收到 notifier 事件，就会从源序列取一个最新的事件并发送。而如果两次 notifier 事件之间没有源序列的事件，则不发送值。
     */
    /// Sample
    func SampleDemo() {
        let source = PublishSubject<Int>()
        let notifier = PublishSubject<String>()
        
        source
            .sample(notifier)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        source.onNext(1)
        
        //让源序列接收接收消息
        notifier.onNext("A")
        
        source.onNext(2)
        
        //让源序列接收接收消息
        notifier.onNext("B")
        notifier.onNext("C")
        
        source.onNext(3)
        source.onNext(4)
        
        //让源序列接收接收消息
        notifier.onNext("D")
        
        source.onNext(5)
        
        //让源序列接收接收消息
        notifier.onCompleted()
        
        /*
         1
         2
         4
         5
         */
    }
    
    /**
     debounce 操作符可以用来过滤掉高频产生的元素，它只会发出这种元素：该元素产生后，一段时间内没有新元素产生。
     换句话说就是，队列中的元素如果和下一个元素的间隔小于了指定的时间间隔，那么这个元素将被过滤掉。
     debounce 常用在用户输入的时候，不需要每个字母敲进去都发送一个事件，而是稍等一下取最后一个事件。
     */
    ///debounce
    func debounceDemo()  {
        //定义好每个事件里的值以及发送的时间
        let times = [
            [ "value": 1, "time": 0.1 ],
            [ "value": 2, "time": 1.1 ],
            [ "value": 3, "time": 1.2 ],
            [ "value": 4, "time": 1.2 ],
            [ "value": 5, "time": 1.4 ],
            [ "value": 6, "time": 2.1 ]
        ]
        
        //生成对应的 Observable 序列并订阅
        Observable.from(times)
            .flatMap { item in
                return Observable.of(Int(item["value"]!))
                    .delaySubscription(Double(item["time"]!),
                                       scheduler: MainScheduler.instance)
            }
            .debounce(0.5, scheduler: MainScheduler.instance) //只发出与下一个间隔超过0.5秒的元素
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        /**
         1
         5
         6
         */

    }
}
