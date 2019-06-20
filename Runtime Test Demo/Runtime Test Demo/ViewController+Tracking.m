//
//  ViewController+Tracking.m
//  Runtime Test Demo
//
//  Created by JQ on 2017/9/20.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "ViewController+Tracking.h"
#import <objc/runtime.h>

@implementation ViewController (Tracking)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        // When swizzling a class method, use the following:
         //Class class = object_getClass((id)self);
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(xxx_viewWillAppear:);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        BOOL didAddMethod = class_addMethod(class,
                                            originalSelector,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}


#pragma mark - Method Swizzling
- (void)xxx_viewWillAppear:(BOOL)animated {
    [self xxx_viewWillAppear:animated];
    NSLog(@"viewWillAppear: %@", self);
    
    NSLog(@"viewWillAppear: %@", NSStringFromClass([self class]));
    
    
    //[self viewWillAppear:animated];   //产生无限循环
    /**
     咋看上去是会导致无限循环的。但令人惊奇的是，并没有出现这种情况。
     在swizzling的过程中，方法中的[self xxx_viewWillAppear:animated]已经被重新指定到UIViewController类的-viewWillAppear:中。
     在这种情况下，不会产生无限循环。不过如果我们调用的是[self viewWillAppear:animated]，则会产生无限循环，因为这个方法的实现在运行时已经被重新指定为xxx_viewWillAppear:了。
     */
}

/**
 在这里，我们通过method swizzling修改了UIViewController的@selector(viewWillAppear:)对应的函数指针，使其实现指向了我们自定义的xxx_viewWillAppear的实现。这样，当UIViewController及其子类的对象调用viewWillAppear时，都会打印一条日志信息。
 
 */

/**
 Swizzling应该总是在+load中执行
 
 在Objective-C中，运行时会自动调用每个类的两个方法。+load会在类初始加载时调用，+initialize会在第一次调用类的类方法或实例方法之前被调用。这两个方法是可选的，且只有在实现了它们时才会被调用。由于method swizzling会影响到类的全局状态，因此要尽量避免在并发处理中出现竞争的情况。+load能保证在类的初始化过程中被加载，并保证这种改变应用级别的行为的一致性。相比之下，+initialize在其执行时不提供这种保证–事实上，如果在应用中没为给这个类发送消息，则它可能永远不会被调用。
 
 Swizzling应该总是在dispatch_once中执行
 
 与上面相同，因为swizzling会改变全局状态，所以我们需要在运行时采取一些预防措施。原子性就是这样一种措施，它确保代码只被执行一次，不管有多少个线程。GCD的dispatch_once可以确保这种行为，我们应该将其作为method swizzling的最佳实践。
 */


/**
 Swizzling通常被称作是一种黑魔法，容易产生不可预知的行为和无法预见的后果。虽然它不是最安全的，但如果遵从以下几点预防措施的话，还是比较安全的：
 
 总是调用方法的原始实现(除非有更好的理由不这么做)：API提供了一个输入与输出约定，但其内部实现是一个黑盒。Swizzle一个方法而不调用原始实现可能会打破私有状态底层操作，从而影响到程序的其它部分。
 避免冲突：给自定义的分类方法加前缀，从而使其与所依赖的代码库不会存在命名冲突。
 明白是怎么回事：简单地拷贝粘贴swizzle代码而不理解它是如何工作的，不仅危险，而且会浪费学习Objective-C运行时的机会。阅读Objective-C Runtime Reference和查看<objc/runtime.h>头文件以了解事件是如何发生的。
 小心操作：无论我们对Foundation, UIKit或其它内建框架执行Swizzle操作抱有多大信心，需要知道在下一版本中许多事可能会不一样。

 */
@end
