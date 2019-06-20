//
//  MTransitionViewController.swift
//  RxSwiftManager
//
//  Created by Majq on 2018/9/20.
//  Copyright © 2018年 Majq. All rights reserved.
//

import UIKit

class MTransitionViewController: UIViewController {

    let obj = MAnimationTransitionProtocal()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupBtn()
    }

    func setupBtn()  {
        let btn = UIButton()
        btn.backgroundColor = UIColor.orange
        btn.setTitle("push", for: .normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15 )
        btn.frame = CGRect(x: 0, y: 100 , width: 100, height: 90/2.0)
        btn.addTarget(self, action: #selector(testAction(_:)), for: .touchUpInside)
        self.view.addSubview(btn)
    }
    
    
    //@objc 允许这个函数在“运行时”通过oc的消息机制调用
    @objc func testAction(_ btn:UIButton){
        
        obj.mAnimationTransition = MAnimationTransition(showType: .scale)
        self.navigationController?.delegate = obj
        
        let vc = MTransition_2ViewController(nibName: "MTransition_2ViewController", bundle: nil)

        self.navigationController?.pushViewController(vc, animated: true)
    }
   
}
