//
//  FirstViewController.swift
//  RxSwiftManager
//
//  Created by Majq on 2018/9/6.
//  Copyright © 2018年 Majq. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class FirstViewController: UIViewController {

    var tableView: UITableView!
    let cellId: String = "cellId"

    //歌曲列表数据源
    let musicListViewModel = MusicListViewModel()
    
    

    //负责对象销毁
    let disposeBag = DisposeBag()
    
    //歌曲列表数据源
    let musicListViewModelRx = MusicListViewModeRx()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        //setUpTableView()  //传统式编程
        
        setupTableViewRx()  //Rx式编程
        
        
    }
    
    
}

// MARK: - 传统式编程
extension FirstViewController: UITableViewDelegate,UITableViewDataSource {

    /// 创建tableView
    func setUpTableView() {

        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), style: .plain)
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self;
        tableView.backgroundColor = UIColor.gray
        tableView.separatorStyle    = .none
        tableView.rowHeight = 100

        tableView.register(UITableViewCell.self , forCellReuseIdentifier: cellId)

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicListViewModel.data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let music = musicListViewModel.data[indexPath.row]
        cell.textLabel?.text = music.name + "   歌手：\(music.singer)  "
        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("你选中的歌曲信息【\(musicListViewModel.data[indexPath.row])】")
    }
}


//歌曲结构体
struct Music {
    let name: String //歌名
    let singer: String //演唱者
    
    init(name: String, singer: String) {
        self.name = name
        self.singer = singer
    }
}

//实现 CustomStringConvertible 协议，方便输出调试
extension Music: CustomStringConvertible {
    var description: String {
        return "name：\(name) singer：\(singer)"
    }
}


//歌曲列表数据源
struct MusicListViewModel {
    let data = [
        Music(name: "无条件", singer: "陈奕迅"),
        Music(name: "你曾是少年", singer: "S.H.E"),
        Music(name: "从前的我", singer: "陈洁仪"),
        Music(name: "在木星", singer: "朴树"),
        ]
}


// MARK: - RxSwift 用法
extension FirstViewController
{
    func setupTableViewRx() {
        //将数据源数据绑定到tableView上
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), style: .plain)
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor.gray
        tableView.separatorStyle    = .none
        tableView.rowHeight = 100
        tableView.register(UITableViewCell.self , forCellReuseIdentifier: cellId)
        
        /**
         代码的简单说明：
         DisposeBag：作用是 Rx 在视图控制器或者其持有者将要销毁的时候，自动释法掉绑定在它上面的资源。它是通过类似“订阅处置机制”方式实现（类似于 NotificationCenter 的 removeObserver）。
         rx.items(cellIdentifier:）:这是 Rx 基于 cellForRowAt 数据源方法的一个封装。传统方式中我们还要有个 numberOfRowsInSection 方法，使用 Rx 后就不再需要了（Rx 已经帮我们完成了相关工作）。
         rx.modelSelected： 这是 Rx 基于 UITableView 委托回调方法 didSelectRowAt 的一个封装。
         
         */
        musicListViewModelRx.data
            .bind(to: tableView.rx.items(cellIdentifier:cellId)) { _, music, cell in
                cell.textLabel?.text = music.name
                cell.detailTextLabel?.text = music.singer
            }.disposed(by: disposeBag)
        
        //tableView点击响应
        tableView.rx.modelSelected(Music.self).subscribe(onNext: { music in
            print("你选中的歌曲信息【\(music)】")
        }).disposed(by: disposeBag)
        
        
    }
}

//歌曲列表数据源
//这里我们将 data 属性变成一个可观察序列对象（Observable Squence），而对象当中的内容和我们之前在数组当中所包含的内容是完全一样的。
//关于可观察序列对象在后面的文章中我会详细介绍。简单说就是“序列”可以对这些数值进行“订阅（Subscribe）”，有点类似于“通知（NotificationCenter）”
struct MusicListViewModeRx {
    let data = Observable.just([
        Music(name: "无条件", singer: "陈奕迅"),
        Music(name: "你曾是少年", singer: "S.H.E"),
        Music(name: "从前的我", singer: "陈洁仪"),
        Music(name: "在木星", singer: "朴树"),
        ])
}

//这里我们不再需要实现数据源和委托协议了。而是写一些响应式代码，让它们将数据和 UITableView 建立绑定关系。
//算了下这里我们只需要 31 行代码，同之前的相比，一下减少了 1/4 代码量。而且代码也更清爽了些。
extension FirstViewController {
    
}























