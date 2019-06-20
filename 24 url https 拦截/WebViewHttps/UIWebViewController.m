//
//  UIWebViewController.m
//  WebViewHttps
//
//  Created by Mac on 2018/8/21.
//  Copyright © 2018年 Mac. All rights reserved.
//
//https://www.cnblogs.com/wobuyayi/p/6283599.html
#import "UIWebViewController.h"
#import "MajqURLSessionProtocol.h"

@interface UIWebViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation UIWebViewController

/**
 
 问题：服务器端有一个网站需要AD认证，整站都开了Basic认证，包括图片，CSS等资源，我在HTTP请求头里面添加认证所需的用户名和密码，传递到服务器端可以认证通过。我在UIWebView的shouldStartLoadWithRequest代理方法中拦截WebView的请求，然后在请求的Header中添加认证所需的用户名和密码，然后使用NSURLSession重新发出HTTP的请求，这种方法可以解决大部分的网络请求，但是无法拦截到网页内部的ajax请求，所以所有的ajax请求都会失败，一旦遇到ajax请求，认证都会失败，并且网页会失去响应？
 
 解决思路：使用NSURLProtocol拦截UIWebView内部的所有请求，包括Ajax请求，在所有的请求头中添加认证所需的用户名和密码。
 
 注意:NSURLProtocol只能拦截UIWebView、NSURLConnection、NSURLSession和基于NSURLConnenction、NSURLSession实现的第三方框架(如AFNetworking)发出的网络请求，无法拦截WKWebview、CFNetwork以及基于CFNetwork实现的第三方框架(如MKNetworkit)发出的网络请求。 //update on 2017-02-28
 
 下面提供一个完整的NSURLProtocol的实现类：
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.zykj188.com/v2/iframepage/index.html#/myPrivilege"]];
    [self.webView loadRequest:request];
    
    //注册网络请求拦截
    [NSURLProtocol registerClass:[MajqURLSessionProtocol class]];
}

- (void)dealloc {
    [NSURLProtocol unregisterClass:[MajqURLSessionProtocol class]];
}


@end
