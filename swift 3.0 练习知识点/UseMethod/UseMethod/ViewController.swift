//
//  ViewController.swift
//  UseMethod
//
//  Created by JQ on 2017/9/8.
//  Copyright © 2017年 Majq. All rights reserved.
//

import UIKit

class Person {
    var name: String = "11"
}




class ViewController: UIViewController {

    var _tableView: MajqTableView = MajqTableView(frame: .zero, style: .plain)
    let cellID = "id"
    let h = UIScreen.main.bounds.size.height
    override func viewDidLoad() {
        super.viewDidLoad()
        
       test02()
        
        
    }
    
    
    private func test01() {
    
        let v =  TestView(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
        v.backgroundColor = UIColor.orange
        print(v)

        for subv in view.subviews {
            print(" class = \(type(of: subv))")
        }
        view.addSubview(v)
        
        view.addSubview(v)
        view.addSubview(v)
        view.addSubview(v)
        view.addSubview(v)
        for subv in view.subviews {
            print(" class = \(type(of: subv))")
        }


        
    }
    
    private func test02() {
    
        let v =  TestView(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
        v.backgroundColor = UIColor.orange
        print("v 的信息\(v)")
        
        
        let v2 =  MView(frame: view.bounds)
        view.addSubview(v2)
        
        
        _tableView.delegate = self
        _tableView.dataSource = self
        _tableView.frame = CGRect(x: 20, y: 0, width: 375, height: h)
        _tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        _tableView.rowHeight = 80
        
        v2.addSubview(_tableView)

        testTableHeaderView_Y(withView: v)

        //testTableHeaderView_N(withView: v)
        
    }
    
    private func testTableHeaderView_Y(withView v: TestView) {
        _tableView.tableHeaderView = v
        for subv in _tableView.subviews {
            print(" class = \(type(of: subv))")
        }
        
        print("----1----")
        print(_tableView)
        
        print("----2----")

        let c1 = _tableView.tableHeaderView?.superview
        print(c1!)
        print(NSStringFromClass(type(of: c1!)))
        print(" class = \(type(of: c1))")
        
        print("----3----")

        let c2 = _tableView.superview
        print(c2!)
        print(" class = \(type(of: c2))")

        /*
         Optional(<UseMethod.TestView: 0x7fb176d06830; frame = (0 0; 375 20); layer = <CALayer: 0x60000003b180>>)
         Optional(<UITableView: 0x7fb17702d400; frame = (20 0; 375 736); clipsToBounds = YES; gestureRecognizers = <NSArray: 0x600000053ad0>; layer = <CALayer: 0x60000003b520>; contentOffset: {0, 0}; contentSize: {375, 1620}>)

         */
    }
    
    private func testTableHeaderView_N(withView v: TestView) {
        
        for subv in _tableView.subviews {
            print(" class = \(type(of: subv))")
        }
        
        print(_tableView.tableHeaderView)
        print(_tableView.tableHeaderView?.superview)
        
        /*
         nil
         nil
         */
    }
    
  
    

}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        cell.contentView.backgroundColor = UIColor.gray

        return cell
    }
}

