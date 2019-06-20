//
//  SixteenthViewController.swift
//  RxSwiftManager
//
//  Created by Majq on 2018/9/18.
//  Copyright © 2018年 Majq. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SixteenthViewController: UIViewController {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.
        
//        single_01()

//        single_02()
        
//        completable_03()
        
//        completable_04()
        
        maybe_05()
        
//        maybe_06()
        
         asMaybe()
    }

   
    
}


// MARK: - Single
extension SixteenthViewController
{
    
    //    public enum SingleEvent<Element> {
    //        case success(Element)
    //        case error(Swift.Error)
    //    }
    /// Single 是 Observable 的另外一个版本。但它不像 Observable 可以发出多个元素，它要么只能发出一个元素，要么产生一个 error 事件。
    /// 发出一个元素，或一个 error 事件
    /// 不会共享状态变化
    /// Single 比较常见的例子就是执行 HTTP 请求，然后返回一个应答或错误。不过我们也可以用 Single 来描述任何只有一个元素的序列。
    /// SingleEvent【.success：里面包含该Single的一个元素值，.error：用于包含错误】
    func single_01() {
        //获取第0个频道的歌曲信息
        getPlaylist("0")
            .subscribe { event in
                switch event {
                case .success(let json):
                    print("JSON结果: ", json)
                case .error(let error):
                    print("发生错误: ", error)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func single_02() {
        //获取第0个频道的歌曲信息
        getPlaylist("0")
            .subscribe(onSuccess: { json in
                print("JSON结果: ", json)
            }, onError: { error in
                print("发生错误: ", error)
            })
            .disposed(by: disposeBag)
    }
    
    //获取豆瓣某频道下的歌曲信息
    //public typealias Single<Element> = PrimitiveSequence<SingleTrait, Element>
    func getPlaylist(_ channel: String) -> Single<[String: Any]> {
        
        return Single<[String: Any]>.create { single in
            let url = "https://douban.fm/j/mine/playlist?"
                + "type=n&channel=\(channel)&from=mainsite"
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, error in
                if let error = error {
                    single(.error(error))
                    return
                }
                
                guard let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data,
                                                                 options: .mutableLeaves),
                    let result = json as? [String: Any] else {
                        single(.error(DataError.cantParseJSON))
                        return
                }
                
                single(.success(result))
            }
            
            task.resume()
            
            return Disposables.create { task.cancel() }
        }
    }
    
    //与数据相关的错误类型
    enum DataError: Error {
        case cantParseJSON
    }
    
    /**
     JSON结果:  ["r": 0, "song": <__NSSingleObjectArrayI 0x600000001120>(
     {
     aid = 3009098;
     album = "/subject/3009098/";
     albumtitle = Tsuki;
     "alert_msg" = "";
     "all_play_sources" =     (
     {
     confidence = "0.911407";
     "file_url" = "<null>";
     "page_url" = "https://h.xiami.com/song.html?id=1769024669&ch=10013988";
     playable = 1;
     source = xm;
     "source_full_name" = Xiami;
     "source_id" = 1769024669;
     }
     );
     artist = Annekei;
     "available_formats" =     {
     128 = 2891;
     192 = 4348;
     320 = 7008;
     64 = 1473;
     };
     "file_ext" = mp4;
     "is_douban_playable" = 1;
     "is_royal" = 0;
     kbps = 128;
     length = 180;
     like = 0;
     "partner_sources" =     (
     );
     picture = "https://img1.doubanio.com/view/subject/m/public/s3042627.jpg";
     "public_time" = 2007;
     release =     {
     id = 3009098;
     link = "https://douban.fm/album/3009098g7146";
     ssid = 7146;
     };
     sha256 = 9f14e6a22bb8e78b271b6bf7014e890ae050c5400aa61fdc18c801a7c9937004;
     sid = 1470586;
     singers =     (
     {
     avatar = "https://img3.doubanio.com/img/fmadmin/large/719934.jpg";
     genre =             (
     Jazz
     );
     id = 31161;
     "is_site_artist" = 0;
     name = Annekei;
     "name_usual" = Annekei;
     region =             (
     "\U4e39\U9ea6"
     );
     "related_site_id" = 0;
     style =             (
     );
     }
     );
     ssid = 5894;
     status = 0;
     subtype = "";
     title = "At Home";
     "update_time" = 1470126154;
     url = "http://mr3.doubanio.com/cdc9dc64bff43bcf094177fdf6cac38e/0/fm/song/p1470586_128k.mp4";
     }
     )
     , "is_show_quick_start": 0]
     
     */
    
}


// MARK: - Completable
extension SixteenthViewController
{
    /**
     Completable 是 Observable 的另外一个版本。不像 Observable 可以发出多个元素，它要么只能产生一个 completed 事件，要么产生一个 error 事件。
     
     不会发出任何元素
     只会发出一个 completed 事件或者一个 error 事件
     不会共享状态变化
     
     Completable 和 Observable<Void> 有点类似。适用于那些只关心任务是否完成，而不需要在意任务返回值的情况。比如：在程序退出时将一些数据缓存到本地文件，供下次启动时加载。像这种情况我们只关心缓存是否成功。
     
     为方便使用，RxSwift 为 Completable 订阅提供了一个枚举（CompletableEvent）：
     
     .completed：用于产生完成事件
     .error：用于产生一个错误
     
     public enum CompletableEvent {
        case error(Swift.Error)
        case completed
     }
 
     */
    
    //（1）创建 Completable 和创建 Observable 非常相似。下面代码我们使用 Completable 来模拟一个数据缓存本地的操作：
    func completable_03() {
        cacheLocally()
            .subscribe { completable in
                switch completable {
                case .completed:
                    print("保存成功!")
                case .error(let error):
                    print("保存失败: \(error.localizedDescription)")
                }
            }
            .disposed(by: disposeBag)
    }
    
    func completable_04 (){
        cacheLocally()
            .subscribe(onCompleted: {
                print("保存成功!")
            }, onError: { error in
                print("保存失败: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)

    }

    //将数据缓存到本地
    func cacheLocally() -> Completable {
        return Completable.create { completable in
            //将数据缓存到本地（这里掠过具体的业务代码，随机成功或失败）
            let success = (arc4random() % 2 == 0)
            
            guard success else {
                completable(.error(CacheError.failedCaching))
                return Disposables.create {}
            }
            
            completable(.completed)
            return Disposables.create {}
        }
    }
    
    //与缓存相关的错误类型
    enum CacheError: Error {
        case failedCaching
    }
  
    
}


// MARK: - Maybe
extension SixteenthViewController
{
    /*
     1，基本介绍
     
     Maybe 同样是 Observable 的另外一个版本。它介于 Single 和 Completable 之间，它要么只能发出一个元素，要么产生一个 completed 事件，要么产生一个 error 事件。
     
     发出一个元素、或者一个 completed 事件、或者一个 error 事件
     不会共享状态变化
     2，应用场景
     
     Maybe 适合那种可能需要发出一个元素，又可能不需要发出的情况。
     
     3，MaybeEvent
     
     为方便使用，RxSwift 为 Maybe 订阅提供了一个枚举（MaybeEvent）：
     
     .success：里包含该 Maybe 的一个元素值
     .completed：用于产生完成事件
     .error：用于产生一个错误
     
     public enum MaybeEvent<Element> {
        case success(Element)
        case error(Swift.Error)
        case completed
     }
     */
    func maybe_05() {
        generateString()
            .subscribe { maybe in
                switch maybe {
                case .success(let element):
                    print("执行完毕，并获得元素：\(element)")
                case .completed:
                    print("执行完毕，且没有任何元素。")
                case .error(let error):
                    print("执行失败: \(error.localizedDescription)")
                    
                }
            }
            .disposed(by: disposeBag)
    }
    
    func maybe_06() {
        generateString()
            .subscribe(onSuccess: { element in
                print("执行完毕，并获得元素：\(element)")
            },
                       onError: { error in
                        print("执行失败: \(error.localizedDescription)")
            },
                       onCompleted: {
                        print("执行完毕，且没有任何元素。")
            })
            .disposed(by: disposeBag)
    }
    
    func asMaybe() {
        Observable.of("1")
            .asMaybe()
            .subscribe({ print($0) })
            .disposed(by: disposeBag)
    }
    
    func generateString() -> Maybe<String> {
        return Maybe<String>.create { maybe in
            
            //成功并发出一个元素
            maybe(.success("hangge.com"))
            
            //成功但不发出任何元素
            maybe(.completed)
            
            //失败
            //maybe(.error(StringError.failedGenerate))
            
            return Disposables.create {}
        }
    }
    
    //与缓存相关的错误类型
    enum StringError: Error {
        case failedGenerate
    }
    
  
}

