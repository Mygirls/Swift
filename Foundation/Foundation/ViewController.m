//
//  ViewController.m
//  Foundation
//
//  Created by cfzq on 2017/6/16.
//  Copyright © 2017年 cfzq. All rights reserved.
//


#import "ViewController.h"
#import "test.h"
#import "MyClass.h"

#pragma mark - ***1.Father***
@interface Father : NSObject
{
    NSString *_name;
}
@end


@implementation Father



@end    //Father end

#pragma mark - ***2.Son***

@interface Son : Father
{
    
}
@end


@implementation Son

void imp_submethod1(id self, SEL _cmd)
{
    // implementation ....
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"%@",NSStringFromClass(self.class));
        NSLog(@"%@",NSStringFromClass(super.class));

        NSLog(@"%@",self.class);
        NSLog(@"%@",super.class);

    }
    return self;
}

@end    //Son end


#pragma mark - ***2.NSObject***
/**
 @interface NSObject <NSObject> {
    Class isa  OBJC_ISA_AVAILABILITY;
 }
 */



#pragma mark - ***ViewController***
@interface ViewController ()

@end

@implementation ViewController




//http://www.jianshu.com/p/6b905584f536
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
//    Son *son = [[Son alloc] init];
//    
//    BOOL result1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
//    BOOL result2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
//    BOOL result3 = [(id)[Son class] isKindOfClass:[Son class]];
//    BOOL result4 = [(id)[Son class] isMemberOfClass:[Son class]];
//    NSLog(@"result1 = %d ,result2 = %d,result3 = %d,result4 = %d",result1,result2,result3,result4);

    NSLog(@"------------test--------------");
    NSLog(@"-");
    NSLog(@"-");

    //http://www.jianshu.com/p/dac31fe23b6a
    test *t = [[test alloc] init];
    [t runtimeTest];
    //绕过晚绑定，自己获取函数指针
    void (*function)(id, SEL) = (void(*)(id, SEL))[t methodForSelector:@selector(runtimeTest)];
    NSObject *obj = [NSObject new];
    function(obj, @selector(randomMethod));
    
    test *t2 = [[test alloc] init];
    [t2 ex_registerClassPair];
    
    //动态创建类
    Class cls = objc_allocateClassPair(MyClass.class, "MySubClass", 0);
    class_addMethod(cls, @selector(submethod1), (IMP)imp_submethod1, "v@:");
    class_replaceMethod(cls, @selector(method1), (IMP)imp_submethod1, "v@:");
    class_addIvar(cls, "_ivar1", sizeof(NSString *), log(sizeof(NSString *)), "i");
    
    objc_property_attribute_t type = {"T", "@\"NSString\""};
    objc_property_attribute_t ownership = { "C", "" };
    objc_property_attribute_t backingivar = { "V", "_ivar1"};
    objc_property_attribute_t attrs[] = {type, ownership, backingivar};
    
    class_addProperty(cls, "property2", attrs, 3);
    objc_registerClassPair(cls);
    
    id instance = [[cls alloc] init];
    [instance performSelector:@selector(submethod1)];
    [instance performSelector:@selector(method1)];
}
- (void)submethod1 {
    NSLog(@"调用了");
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
