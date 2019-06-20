//
//  ViewController.swift
//  RxSwiftManager
//
//  Created by Majq on 2018/9/6.
//  Copyright © 2018年 Majq. All rights reserved.
//
/**
 *参考博客：https://www.aliyun.com/jiaocheng/371512.html
 *参考博客：https://www.jianshu.com/p/f61a5a988590   //重点参考
 *中文文档：https://beeth0ven.github.io/RxSwift-Chinese-Documentation/
 */
import UIKit



class ViewController: UIViewController {
    
    let cellId: String = "cellId"
    
    /// 数据源
    var dataArray: [String]?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rx 用法"
//        if #available(iOS 11.0, *) {
//            self.navigationController?.navigationBar.prefersLargeTitles = true
//            //self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
//        }
        
        tableView()
        
        dataArray = ["闭包知识",
                     "响应式编程与传统式编程的比较样例",
                     "Observable介绍、创建可观察序列",
                     "Observable订阅、事件监听、订阅销毁",
                     "观察者1： AnyObserver、Binder",
                     "观察者2： 自定义可绑定属性",
                     "Subjects、Variables",
                     "变换操作符：buffer、map、flatMap、scan等",
                     "过滤操作符：filter、take、skip等",
                     "条件和布尔操作符：amb、takeWhile、skipWhile等",
                     "结合操作符：startWith、merge、zip等",
                     "算数&聚合操作符：toArray、reduce、concat",
                     "连接操作符：connect、publish、replay、multicast",
                     "其他操作符：delay、materialize、timeout等",
                     "错误处理",
                     "调试操作",
                     "特征序列1：Single、Completable、Maybe",
                     "特征序列2：Driver",
                     "特征序列3：ControlProperty、 ControlEvent",
                     "调度器、subscribeOn、observeOn",
                     "UI控件扩展"
                    ]
        navBtn()
        navBtn_02() 
        //print(Int.max)
        
    }
    
    

    deinit {
        
        #if DEBUG
        print("\(self) 销毁了")
        #endif
    }
    
  
}


// MARK: - 导航按钮
extension ViewController {
    func navBtn()  {
        let btn = UIButton()
        btn.backgroundColor = UIColor.orange
        btn.setTitle("push动画测试", for: .normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15 )
        btn.frame = CGRect(x: 0, y: 100 , width: 100, height: 90/2.0)
        btn.addTarget(self, action: #selector(testAction(_:)), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        
    }
    
    func navBtn_02()  {
        let btn = UIButton()
        btn.backgroundColor = UIColor.orange
        btn.setTitle("工具类测试", for: .normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15 )
        btn.frame = CGRect(x: 0, y: 100 , width: 100, height: 90/2.0)
        btn.addTarget(self, action: #selector(testAction_02(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
    }
    
    
    //@objc 允许这个函数在“运行时”通过oc的消息机制调用
    @objc func testAction(_ btn:UIButton){
        self.navigationController?.pushViewController(MTransitionViewController(), animated: true)
        
    }
    
    //@objc 允许这个函数在“运行时”通过oc的消息机制调用
    @objc func testAction_02(_ btn:UIButton){
        self.navigationController?.pushViewController(ToolTestViewController(), animated: true)
    }
}


// MARK: - 协议
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    /**
     RxSwift：它只是基于 Swift 语言的 Rx 标准实现接口库，所以 RxSwift 里不包含任何 Cocoa 或者 UI方面的类。
     RxCocoa：是基于 RxSwift针对于 iOS开发的一个库，它通过 Extension 的方法给原生的比如 UI 控件添加了 Rx 的特性，使得我们更容易订阅和响应这些控件的事件。
     */
    
    
    /// 创建tableView
    func tableView() {
        
        let tableView:UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), style: .plain)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self;
        tableView.backgroundColor = UIColor.gray
        tableView.separatorStyle    = .none
        tableView.register(UITableViewCell.self , forCellReuseIdentifier: cellId)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let d = dataArray ?? dataArray!
        return d.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.selectionStyle = .none
        let d = dataArray ?? dataArray!
        cell.textLabel?.text = "\(indexPath.row)" + "、" + d[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc: UIViewController? = nil
        if indexPath.row == 0 {
            vc = ClouseViewController()
            
        } else if indexPath.row == 1 {
            vc = FirstViewController()
            
        } else if indexPath.row == 2 {
            vc = SecondViewController()

        } else if indexPath.row == 3 {
            vc = ThirdViewController()
            
        } else if indexPath.row == 4 {
            vc = FourthViewController(nibName: "FourthViewController", bundle: nil)
            
        } else if indexPath.row == 5 {
            vc = FifthveViewController(nibName: "FifthveViewController", bundle: nil)
            
        } else if indexPath.row == 6 {
            vc = SixthViewController(nibName: "SixthViewController", bundle: nil)
            
        } else if indexPath.row == 7 {
            vc = SeventhViewController(nibName: "SeventhViewController", bundle: nil)
            
        } else if indexPath.row == 8 {
            vc = EighthViewController(nibName: "EighthViewController", bundle: nil)
            
        } else if indexPath.row == 9 {
            vc = NinthViewController(nibName: "NinthViewController", bundle: nil)
            
        } else if indexPath.row == 10 {
            vc = TenthViewController()
            
        } else if indexPath.row == 11 {
            vc = EleventhViewController()
            
        } else if indexPath.row == 12 {
            vc = TwelfthViewController()
            
        } else if indexPath.row == 13 {
            vc = ThirteenthViewController()
            
        } else if indexPath.row == 14 {
            vc = FourteenthViewController()
            
        } else if indexPath.row == 15 {
            vc = FifteenthViewController()
            
        } else if indexPath.row == 16 {
            vc = SixteenthViewController()
            
        } else if indexPath.row == 17 {
            vc = SeventeenthViewController()
            
        } else if indexPath.row == 18 {
            vc = EighteenthViewController()
            
        } else if indexPath.row == 19 {
            
        }  else if indexPath.row == 20 {
            vc = RxUsedViewController()
        }
        
        
        let d = dataArray ?? dataArray!
        vc?.title = d[indexPath.row]
        guard let temp  = vc else { return  }
        self.navigationController?.pushViewController(temp , animated: true)

        
    }
}

extension ViewController
{
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        print("控制器1 viewWillAppear")
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        print("控制器1 viewWillDisappear")
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        print("控制器1 viewDidAppear")
//    }
//    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        print("控制器1 viewDidDisappear")
//    }
    
    /**
     生命周期
     控制器1 viewWillAppear
     控制器1 viewDidAppear
     
     控制器1 viewWillDisappear
     控制器2 viewWillAppear
     控制器1 viewDidDisappear
     控制器2 viewDidAppear
     
     控制器2 viewWillDisappear
     控制器1 viewWillAppear
     控制器2 viewDidDisappear
     控制器1 viewDidAppear

     <RxSwiftManager.ClouseViewController: 0x7feb1be1b3a0> 销毁了

     */
}


