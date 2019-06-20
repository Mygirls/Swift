//
//  main.m
//  Foundation
//
//  Created by cfzq on 2017/6/16.
//  Copyright © 2017年 cfzq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <objc/runtime.h>
#import "MyClass.h"
//#import "MySubClass.h"

void methImpl_MyClass_whoAmI(id self,SEL cmd) {
    NSLog(@"%@",self);
}

void myMethodIMP(id self, SEL _cmd)
{
    // implementation ....
}

struct stu {
    char *name;
    int num;
    int age;
    char group;
    float score;
    
} stu1 = {"Tom",12,16,'A',1233.9};


int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        
        NSLog(@"Hello world");
        
        id rootClass = objc_getClass("NSObject");
        id MyClass01 = nil;
        MyClass01 = objc_allocateClassPair(rootClass, "MyClass01", sizeof(int)  );
        class_addMethod(MyClass01, @selector(whoAmI), (IMP)methImpl_MyClass_whoAmI, "V@:");
        [[MyClass01 new] performSelector:@selector(whoAmI)];
        
        //2017-06-19 10:09:56.454 Foundation[1721:189349] Hello world
        //2017-06-19 10:09:56.558 Foundation[1721:189349] <MyClass01: 0x60000000d410>
        
        
        //结构体指针
        struct stu *pstu = &stu1;
        printf("%s的学号是%d，年龄是%d，在%c组，今年的成绩是%.1f！\n", (*pstu).name, (*pstu).num, (*pstu).age, (*pstu).group, (*pstu).score);
        printf("%s的学号是%d，年龄是%d，在%c组，今年的成绩是%.1f！\n", pstu->name, pstu->num, pstu->age, pstu->group, pstu->score);
        //Tom的学号是12，年龄是16，在A组，今年的成绩是1233.9！

        
        
        MyClass *myClass = [[MyClass alloc] init];
        unsigned int outCount = 0;
        
        Class cls = myClass.class;
        
        // 类名
        NSLog(@"class name: %s", class_getName(cls));
        
        NSLog(@"==========================================================");
        
        // 父类
        NSLog(@"super class name: %s", class_getName(class_getSuperclass(cls)));
        NSLog(@"==========================================================");
        
        // 是否是元类
        NSLog(@"MyClass is %@ a meta-class", (class_isMetaClass(cls) ? @"" : @"not"));
        NSLog(@"==========================================================");
        
        Class meta_class = objc_getMetaClass(class_getName(cls));
        NSLog(@"%s's meta-class is %s", class_getName(cls), class_getName(meta_class));
        NSLog(@"==========================================================");
        
        // 变量实例大小
        NSLog(@"instance size: %zu", class_getInstanceSize(cls));
        NSLog(@"==========================================================");
        
        // 成员变量
        Ivar *ivars = class_copyIvarList(cls, &outCount);
        for (int i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSLog(@"instance variable's name: %s at index: %d", ivar_getName(ivar), i);
        }
        
        free(ivars);
        
        Ivar string = class_getInstanceVariable(cls, "_string");
        if (string != NULL) {
            NSLog(@"instace variable %s", ivar_getName(string));
        }
        
        NSLog(@"==========================================================");
        
        // 属性操作
        objc_property_t * properties = class_copyPropertyList(cls, &outCount);
        for (int i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            NSLog(@"property's name: %s", property_getName(property));
        }
        
        free(properties);
        
        objc_property_t array = class_getProperty(cls, "array");
        if (array != NULL) {
            NSLog(@"property %s", property_getName(array));
        }
        
        NSLog(@"==========================================================");
        
        // 方法操作
        Method *methods = class_copyMethodList(cls, &outCount);
        for (int i = 0; i < outCount; i++) {
            Method method = methods[i];
            NSLog(@"method's signature: %s", method_getName(method));
        }
        
        free(methods);
        
        Method method1 = class_getInstanceMethod(cls, @selector(method1));
        if (method1 != NULL) {
            NSLog(@"method %s", method_getName(method1));
        }
        
        Method classMethod = class_getClassMethod(cls, @selector(classMethod1));
        if (classMethod != NULL) {
            NSLog(@"class method : %s", method_getName(classMethod));
        }
        
        NSLog(@"MyClass is%@ responsd to selector: method3WithArg1:arg2:", class_respondsToSelector(cls, @selector(method3WithArg1:arg2:)) ? @"" : @" not");
        
        IMP imp = class_getMethodImplementation(cls, @selector(method1));
        imp();
        
        NSLog(@"==========================================================");
        
        // 协议
        Protocol * __unsafe_unretained * protocols = class_copyProtocolList(cls, &outCount);
        Protocol * protocol;
        for (int i = 0; i < outCount; i++) {
            protocol = protocols[i];
            NSLog(@"protocol name: %s", protocol_getName(protocol));
        }
        
        NSLog(@"MyClass is%@ responsed to protocol %s", class_conformsToProtocol(cls, protocol) ? @"" : @" not", protocol_getName(protocol));
        
        NSLog(@"==========================================================");
 
        
        
        
        
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

/*
 
 2017-06-20 14:50:38.398 Foundation[11153:1560129] class name: MyClass
 2017-06-20 14:50:38.399 Foundation[11153:1560129] ==========================================================
 2017-06-20 14:50:38.400 Foundation[11153:1560129] super class name: NSObject
 2017-06-20 14:50:38.400 Foundation[11153:1560129] ==========================================================
 2017-06-20 14:50:38.400 Foundation[11153:1560129] MyClass is not a meta-class
 2017-06-20 14:50:38.401 Foundation[11153:1560129] ==========================================================
 2017-06-20 14:50:46.965 Foundation[11153:1560129] MyClass's meta-class is MyClass
 2017-06-20 14:50:46.965 Foundation[11153:1560129] ==========================================================
 2017-06-20 14:50:46.965 Foundation[11153:1560129] instance size: 48
 2017-06-20 14:50:46.966 Foundation[11153:1560129] ==========================================================
 2017-06-20 14:50:46.966 Foundation[11153:1560129] instance variable's name: _instance1 at index: 0
 2017-06-20 14:50:46.966 Foundation[11153:1560129] instance variable's name: _instance2 at index: 1
 2017-06-20 14:50:46.967 Foundation[11153:1560129] instance variable's name: _array at index: 2
 2017-06-20 14:50:46.967 Foundation[11153:1560129] instance variable's name: _string at index: 3
 2017-06-20 14:50:46.967 Foundation[11153:1560129] instance variable's name: _integer at index: 4
 2017-06-20 14:50:46.967 Foundation[11153:1560129] instace variable _string
 2017-06-20 14:50:46.967 Foundation[11153:1560129] ==========================================================
 2017-06-20 14:50:46.968 Foundation[11153:1560129] property's name: integer
 2017-06-20 14:50:46.968 Foundation[11153:1560129] property's name: array
 2017-06-20 14:50:46.968 Foundation[11153:1560129] property's name: string
 2017-06-20 14:50:46.968 Foundation[11153:1560129] property array
 2017-06-20 14:50:46.968 Foundation[11153:1560129] ==========================================================
 2017-06-20 14:50:46.969 Foundation[11153:1560129] method's signature: method1
 2017-06-20 14:50:46.980 Foundation[11153:1560129] method's signature: method2
 2017-06-20 14:50:46.980 Foundation[11153:1560129] method's signature: method3WithArg1:arg2:
 2017-06-20 14:50:46.981 Foundation[11153:1560129] method's signature: integer
 2017-06-20 14:50:46.981 Foundation[11153:1560129] method's signature: setInteger:
 2017-06-20 14:50:46.981 Foundation[11153:1560129] method's signature: setArray:
 2017-06-20 14:50:46.982 Foundation[11153:1560129] method's signature: .cxx_destruct
 2017-06-20 14:50:46.982 Foundation[11153:1560129] method's signature: setString:
 2017-06-20 14:50:46.982 Foundation[11153:1560129] method's signature: array
 2017-06-20 14:50:46.983 Foundation[11153:1560129] method's signature: string
 2017-06-20 14:50:46.983 Foundation[11153:1560129] method method1
 2017-06-20 14:50:46.983 Foundation[11153:1560129] class method : classMethod1
 2017-06-20 14:50:46.984 Foundation[11153:1560129] MyClass is responsd to selector: method3WithArg1:arg2:
 2017-06-20 14:50:46.984 Foundation[11153:1560129] call method method1
 2017-06-20 14:50:46.984 Foundation[11153:1560129] ==========================================================
 2017-06-20 14:50:46.984 Foundation[11153:1560129] protocol name: NSCopying
 2017-06-20 14:50:46.985 Foundation[11153:1560129] protocol name: NSCoding
 2017-06-20 14:50:46.985 Foundation[11153:1560129] MyClass is responsed to protocol NSCoding
 2017-06-20 14:50:46.985 Foundation[11153:1560129] ==========================================================

 
 */




