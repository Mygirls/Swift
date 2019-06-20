//
//  MTURLSessionProtocol.m
//  WebViewHttps
//
//  Created by Mac on 2018/8/21.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "MajqURLSessionProtocol.h"

static NSString *const MTURLProtocolHandleKey = @"MTURLProtocolHandleKey";

@interface MajqURLSessionProtocol()<NSURLSessionDelegate>

@property (atomic ,strong, readwrite) NSURLSessionDataTask *task; // 确保原子性，数据安全
@property (nonatomic, strong) NSURLSession *session;

@end

@implementation MajqURLSessionProtocol

/**
 *  确定协议子类是否可以处理指定的请求
 *
 *  @param request 请求处理。
 *  @return YES如果协议子类可以处理request，否则NO。
 */
+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    // 只处理https请求
    NSString *scheme = [[request URL] scheme];
    if ([scheme caseInsensitiveCompare:@"http"] == NSOrderedSame ||
        [scheme caseInsensitiveCompare:@"https"] == NSOrderedSame) {
        NSLog(@"====>%@",request.URL);
        // 防止无限循环
        /* 防止无限循环，因为一个请求在被拦截处理过程中，也会发起一个请求，这样又会走到这里，如果不进行处理，就会造成无限循环 */
        if ([NSURLProtocol propertyForKey:MTURLProtocolHandleKey inRequest:request]) {
            return NO;
        }
        return YES;
    }
    return NO;
}

/**
 *  由每个具体的协议实现来定义“规范”的含义。协议应该保证相同的输入请求总是产生相同的规范形式
 *  在实现此方法时应特别注意，因为请求的规范形式用于查找URL缓存中的对象，该缓存是在URLRequest实例之间执行相等性检查的过程。
 *
 *  这是一个抽象方法，子类必须提供实现
 *
 *@param request NSURLRequest
 *@return 返回指定请求的规范版本。
 */

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    /** 可以在此处添加头等信息  */
    NSMutableURLRequest *mutableReqeust = [request mutableCopy];
    return mutableReqeust;
}

//在得到了需要的请求对象之后，就可以初始化一个 NSURLProtocol 对象了：
//子类应重写此方法以执行任何自定义初始化。不要显式调用此方法。注册自定义协议类时，系统将根据需要初始化协议实例。
//这是指定的初始化程序NSURLProtocol。
//- (instancetype)initWithRequest:(NSURLRequest *)request cachedResponse:(NSCachedURLResponse *)cachedResponse client:(id<NSURLProtocolClient>)client
//{
//    //在这里直接调用 super 的指定构造器方法，实例化一个对象，然后就进入了发送网络请求，获取数据并返回的阶段了：
//    return [super initWithRequest:request cachedResponse:cachedResponse client:client];
//}

/**
 *  启动特定于协议的请求加载。
 *  调用此方法时，子类实现应该开始加载请求，通过协议向URL加载系统提供反馈。
 *  NSURLProtocolClient(不要在您的应用程序中实现此协议。相反，您的NSURLProtocol子类在其自己的client属性上调用此协议的方法)
 *
 *  子类必须实现此方法。
 */
- (void)startLoading {
    /*
     *你可以在 - startLoading 中使用任何方法来对协议对象持有的 request 进行转发，包括 NSURLSession、 NSURLConnection
     *甚至使用 AFNetworking 等网络库，只要你能在回调方法中把数据传回 client，帮助其正确渲染就可以
     */
    
    NSMutableURLRequest *mutableReqeust = [[self request] mutableCopy];
    // 表示该请求已经被处理，防止无限循环
    [NSURLProtocol setProperty:@YES forKey:MTURLProtocolHandleKey inRequest:mutableReqeust];
    
    NSURLSessionConfiguration *configure = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    self.session  = [NSURLSession sessionWithConfiguration:configure delegate:self delegateQueue:queue];
    self.task = [self.session dataTaskWithRequest:mutableReqeust];
    [self.task resume];
}

/**
 *  停止特定于协议的请求加载。
 *  调用此方法时，子类实现应停止加载请求。
 *  这可能是对取消操作的响应，因此协议实现必须能够在加载过程中处理此调用。当您的协议收到对此方法的调用时，它也应该停止向客户端发送通知。
 *
 *  子类必须实现此方法。
 */
- (void)stopLoading
{
    [self.session invalidateAndCancel];
    self.session = nil;
}


#pragma mark - NSURLSessionDelegate

//作为与特定任务相关的最后一条消息发送。错误可能为零，这意味着没有发生错误，此任务已完成。
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (error != nil) {
        [self.client URLProtocol:self didFailWithError:error];
    }else
    {
        [self.client URLProtocolDidFinishLoading:self];
    }
}

//该任务已经接收到响应，并且在调用完成块之前将不再接收其他消息。
//配置允许您取消请求或将数据任务转换为下载任务。此委托消息是可选的——如果您不实现它，则可以将响应作为任务的属性来获取。
//此方法不会被调用用于后台上传任务（不能转换为下载任务）。
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
                                 didReceiveResponse:(NSURLResponse *)response
                                  completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    //client 可以理解为当前网络请求的发起者，
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    completionHandler(NSURLSessionResponseAllow);
}

//当数据可供代表使用时发送。假设委托将保留而不复制数据。由于数据可能是不连续的，所以应该使用[NStaseNeaveTyByTangangsUsBug:]访问它。
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    [self.client URLProtocol:self didLoadData:data];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask willCacheResponse:(NSCachedURLResponse *)proposedResponse completionHandler:(void (^)(NSCachedURLResponse * _Nullable))completionHandler
{
    completionHandler(proposedResponse);
}

//MARK: - 重定向请求
//HTTP请求尝试执行对不同URL的重定向。
//您必须调用完成例程以允许重定向，允许修改的请求重定向，或者将NIL传递给FuleTyPrand处理程序，以使重定向响应的主体作为该请求的有效载荷被传递。
//默认是遵循重定向。对于后台会话中的任务，总是遵循重定向，该方法将不被调用。
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)newRequest completionHandler:(void (^)(NSURLRequest *))completionHandler
{
    NSMutableURLRequest*    redirectRequest;
    redirectRequest = [newRequest mutableCopy];
    [[self class] removePropertyForKey:MTURLProtocolHandleKey inRequest:redirectRequest];
    // 重定向请求
    [[self client] URLProtocol:self wasRedirectedToRequest:redirectRequest redirectResponse:response];
    
    [self.task cancel];
    [[self client] URLProtocol:self didFailWithError:[NSError errorWithDomain:NSCocoaErrorDomain code:NSUserCancelledError userInfo:nil]];
}

//MARK: - HTTPS证书认证
//当发生连接级别身份验证挑战时如果实现，该委托将有机会向基础连接提供身份验证凭据。
//某些类型的身份验证将应用于对服务器的给定连接（SSL服务器信任挑战）上的多个请求。如果未实现此委托消息，则行为将使用默认处理，这可能涉及用户交互。
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    
    NSURLCredential * credential;
    assert(challenge != nil);
    credential = nil;
    NSLog(@"----received challenge----");
    NSString *authenticationMethod = [[challenge protectionSpace] authenticationMethod];
    
    if ([authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSLog(@"----server verify client----");
        NSString *host = challenge.protectionSpace.host;
        SecTrustRef serverTrust = challenge.protectionSpace.serverTrust;
        BOOL validDomain = false;
        
        NSMutableArray *polices = [NSMutableArray array];
        if (validDomain) {
            [polices addObject:(__bridge_transfer id)SecPolicyCreateSSL(true, (__bridge CFStringRef)host)];
        } else{
            [polices addObject:(__bridge_transfer id)SecPolicyCreateBasicX509()];
        }
        SecTrustSetPolicies(serverTrust, (__bridge CFArrayRef)polices);
        //pin mode for certificate
        NSString *path = [[NSBundle mainBundle] pathForResource:@"client" ofType:@"cer"];
        NSData *certData = [NSData dataWithContentsOfFile:path];
        NSMutableArray *pinnedCerts = [NSMutableArray arrayWithObjects:(__bridge_transfer id)SecCertificateCreateWithData(NULL, (__bridge CFDataRef)certData), nil];
        SecTrustSetAnchorCertificates(serverTrust, (__bridge CFArrayRef)pinnedCerts);
        credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        
    } else {
        NSLog(@"----client verify server----");
        SecIdentityRef identity = NULL;
        SecTrustRef trust = NULL;
        NSString *p12 = [[NSBundle mainBundle] pathForResource:@"client" ofType:@"p12"];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:p12]) {
            NSLog(@"client.p12 file not exist!");
        } else{
            NSData *pkcs12Data = [NSData dataWithContentsOfFile:p12];
            if ([[self class] extractIdentity:&identity andTrust:&trust fromPKCS12Data:pkcs12Data]) {
                SecCertificateRef certificate = NULL;
                SecIdentityCopyCertificate(identity, &certificate);
                const void *certs[] = {certificate};
                CFArrayRef certArray = CFArrayCreate(kCFAllocatorDefault, certs, 1, NULL);
                credential = [NSURLCredential credentialWithIdentity:identity certificates:(__bridge NSArray *)certArray persistence:NSURLCredentialPersistencePermanent];
                completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
            }
        }
    }
}


+ (BOOL)extractIdentity:(SecIdentityRef *)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
    
    OSStatus securityErr = errSecSuccess;
    NSDictionary *optionsDic = [NSDictionary dictionaryWithObject:@"123321" forKey:(__bridge id)kSecImportExportPassphrase];
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityErr = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data, (__bridge CFDictionaryRef)optionsDic, &items);
    
    if (securityErr == errSecSuccess) {
        CFDictionaryRef mineIdentAndTrust = CFArrayGetValueAtIndex(items, 0);
        const void *tmpIdentity = NULL;
        tmpIdentity = CFDictionaryGetValue(mineIdentAndTrust, kSecImportItemIdentity);
        
        *outIdentity = (SecIdentityRef)tmpIdentity;
        const void *tmpTrust = NULL;
        tmpTrust = CFDictionaryGetValue(mineIdentAndTrust, kSecImportItemTrust);
        *outTrust = (SecTrustRef)tmpTrust;
        
    } else{
        return false;
    }
    return true;
    
}



@end
