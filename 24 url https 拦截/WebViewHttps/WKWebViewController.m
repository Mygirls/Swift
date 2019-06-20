//
//  WKWebViewController.m
//  WebViewHttps
//
//  Created by Mac on 2018/8/21.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import "MajqURLSessionProtocol.h"
#import "NSURLProtocol+WebKitSupport.h"

@interface WKWebViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 比UIWebView多了注册scheme这一步
    for (NSString *scheme in @[@"http", @"https"]) {
        [NSURLProtocol wk_registerScheme:scheme];
    }

    NSString * _webUrlString = @"http://192.168.0.200:8081/index.html#/invite";

    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    //@"https://www.zykj188.com/v2/iframepage/index.html#/myPrivilege"
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_webUrlString ]];
    [self.webView loadRequest:request];
    
    //注册网络请求拦截
    [NSURLProtocol registerClass:[MajqURLSessionProtocol class]];
}

- (void)dealloc {
    [NSURLProtocol unregisterClass:[MajqURLSessionProtocol class]];
}


@end
