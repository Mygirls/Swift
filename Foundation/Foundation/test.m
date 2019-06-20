//
//  test.m
//  Foundation
//
//  Created by cfzq on 2017/6/19.
//  Copyright © 2017年 cfzq. All rights reserved.
//

#import "test.h"
void TestMetaClass(id self, SEL _cmd) {
    
    NSLog(@"This objcet is %p", self);
    NSLog(@"Class is %@, super class is %@", [self class], [self superclass]);
    
    Class currentClass = [self class];
    for (int i = 0; i < 4; i++) {
        //NSLog(@"-----%@",[currentClass class]);

        NSLog(@"Following the isa pointer %d times gives %p", i, currentClass);
        currentClass = objc_getClass((__bridge void *)currentClass);
    }
    
    NSLog(@"NSObject's class is %p", [NSObject class]);
    NSLog(@"NSObject's meta class is %p", objc_getClass((__bridge void *)[NSObject class]));
    /**
     2017-06-20 14:06:43.573 Foundation[10905:1297643] This objcet is 0x60000005bd50
     2017-06-20 14:06:48.007 Foundation[10905:1297643] Class is TestClass, super class is NSError
     2017-06-20 14:07:32.534 Foundation[10905:1297643] Following the isa pointer 0 times gives 0x60000005bcc0
     2017-06-20 14:08:05.072 Foundation[10905:1297643] Following the isa pointer 1 times gives 0x0
     2017-06-20 14:08:07.454 Foundation[10905:1297643] Following the isa pointer 2 times gives 0x0
     2017-06-20 14:08:09.131 Foundation[10905:1297643] Following the isa pointer 3 times gives 0x0
     2017-06-20 14:08:10.506 Foundation[10905:1297643] NSObject's class is 0x106f92e88
     2017-06-20 14:08:11.005 Foundation[10905:1297643] NSObject's meta class is 0x0
    
     解读：
     
     我们在for循环中，我们通过objc_getClass来获取对象的isa，并将其打印出来，依此一直回溯到NSObject的meta-class。分析打印结果，可以看到最后指针指向的地址是0x0，即NSObject的meta-class的类地址。
     这里需要注意的是：我们在一个类对象调用class方法是无法获取meta-class，它只是返回类而已

     */
}

@implementation test

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        NSLog(@"%@",NSStringFromClass(self.class));
//        NSLog(@"%@",NSStringFromClass(super.class));
//        
//        NSLog(@"%@",self.class);
//        NSLog(@"%@",super.class);
//        
//    }
//    return self;
//}

- (void)runtimeTest {
    NSLog(@"self: %@", [self class]);
    NSLog(@"_cmd: %@", NSStringFromSelector(_cmd));
    NSLog(@"----------------------");
    /*
     
     self: test
     2017-06-20 14:58:40.543 Foundation[11268:1605961] _cmd: runtimeTest
     2017-06-20 14:58:43.903 Foundation[11268:1605961] ----------------------
     2017-06-20 14:58:50.654 Foundation[11268:1605961] self: NSObject
     2017-06-20 14:58:50.654 Foundation[11268:1605961] _cmd: randomMethod
     2017-06-20 14:58:50.654 Foundation[11268:1605961] ----------------------
     
     第一次正常的消息发送得到了正常的输出结果，即self的类型就是当前对象的类型，_cmd的名字也是当前方法的名字。而第二次，绕过晚绑定时，self的类型不再是当前对象的类型了，而_cmd的名字也不再是自己方法的名字了。
     
     这也就验证了，self和_cmd只是形参，只是运行时系统会“恰好”把正确的receiver和正确的selector传递过去。
     */
}

- (void)randomMethod {
    NSLog(@"random Method");
}

- (void)ex_registerClassPair {
    
    Class newClass = objc_allocateClassPair([NSError class], "TestClass", 0);
    class_addMethod(newClass, @selector(testMetaClass), (IMP)TestMetaClass, "v@:");
    objc_registerClassPair(newClass);
    
    id instance = [[newClass alloc] initWithDomain:@"some domain" code:0 userInfo:nil];
    [instance performSelector:@selector(testMetaClass)];
}

- (void)testMetaClass {
    NSLog(@"方法调用了");
}


@end
