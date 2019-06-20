//
//  MajqInLineTest.m
//  WebViewHttps
//
//  Created by Majq on 2018/8/21.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "MajqInLineTest.h"

//普通函数
void demo01(int a,int b) {
    if (a != b) {
        printf("普通函数: %d \n",a + b);
    } else {
        printf("普通函数: %d \n",a - b);
    }
}

//内联函数
static inline void demo02(int a,int b) {
    if (a != b) {
        printf("内联函数: %d \n",a + b);
    } else {
        printf("内联函数: %d \n",a - b);
    }
}

@implementation MajqInLineTest
/**
 https://blog.csdn.net/shuai_214/article/details/70800082
 https://blog.csdn.net/coderMy/article/details/52910274
 https://www.cnblogs.com/ysk-china/p/5899495.html
 
 swift
 https://github.com/vandadnp/swift-weekly/blob/master/issue11/README.md#inline
 
 1）什么是内联函数 ?
    内联函数也是函数 , 只是用 inline修饰而已.
 
 2）内联函数和宏定义的区别 ?
    内联函数和宏非常相似 , 但是效率比宏要高 , 且安全性也要高于宏 .
    宏定义 , 只是简单的表面替换 , 且替换时机为预编译处理时 .
    而内联函数不一样 , 内联函数只会在编译时进行处理 , 包括参数 , 返回值检查等 , 就像对待一个真正的函数一样
 
 3）内联函数的优缺点 ?
 
     优点:
     引入内联函数是为了解决函数调用效率的问题
     1.由于函数之间的调用，会从一个内存地址调到另外一个内存地址，当函数调用完毕之后还会返回原来函数执行的地址。
       函数调用会有一定的时间开销，引入内联函数就是为了解决这一问题。且每调用一次函数 , 都会函数进行压栈 , 调用结束再出栈 .
       如果该函数调用频率非常高的话 , 大部分效率都浪费在了进出栈上 , 为了改善这一状况 , 防止反复进出栈 , 于是使用到了内联函数 , 有效解决这一问题 .
     2.由于编译时会对该定义的内联函数进行安全检查 , 所以可以一定程度在编译时就检查出错误 , 而不是在程序运行中crash掉
 
     缺点:
     当然有利也有弊 , 内联函数虽然解决了反复进出栈的消耗, 但是直接性的也造成了内存占用问题 , 但是只要函数不是太过于庞大 , 我想在这个移动端如此强大的时代 , 可以忽视掉这点内存消耗 . 网上有个例子举得很好 .
     不使用内联函数之前 , 就好比去超市买东西 , 超市离家比较远 , 大部分时间都花在了去和回的路上 , 然后你觉得这样效率不高 , 于是把超市搬到了家里 . 然而超市非常的大 , 买东西虽然很近了 ,但是副作用是 家里空间必须要扩大 .

 */

- (void)testInlineMethod
{
    
    demo01(2,3);
    
    demo02(2,3);
   
    /*
     上述情况使用内联函数即可提高效率.
     
     在项目中的应用 , 可以选择使用在一些调用比较频繁的函数里 . 比如一些工具性的函数 等等. 比如在我们项目中 , 在二次封装的AFN和细分模块接口之间的衔接就是用内联函数来完成 . (二次封装请求 + 内敛函数拼接细分模块后缀)
     
     一般项目 :
     细分模块请求 —>内联函数(拼接 baseUrl + /login)—>返回细分模块请求 —–>二次封装AFN —-> AFN —>服务器
     
     大型项目 :
     最小模块请求 —>内联函数(拼接模块名user + /login) —>上级内联函数 (拼接baseUrl + user/login) —>二次封装AFN —>AFN —>服务器
     
     */
}


@end
