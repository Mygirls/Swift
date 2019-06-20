//
//  Test.m
//  Runtime Test Demo
//
//  Created by JQ on 2017/9/20.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "Test.h"
#import <objc/runtime.h>
static NSString *archiverPath = @"singAny1";
@implementation Test

#pragma mark - RunTime: Method Swizzling 

+ (void)clearGDFile
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/singAny"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:path]) {
        [fm removeItemAtPath:path error:nil];
        
    }
}

+ (void)setArchiver:(NSArray *)array
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/singAny"];
    NSData *archiverData = [NSKeyedArchiver archivedDataWithRootObject:array];
    BOOL result = [archiverData writeToFile:path atomically:YES];
    if (result) {
        NSLog(@"归档成功:%@",path);
    }else
    {
        NSLog(@"归档不成功!!!");
    }
}

+ (NSArray *)analysisArchiver
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/singAny"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:path]) {
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return array;
        
    }else{
        return nil;
    }
}

+(void)load
{
    [self changeXTFF1];
    [self changeXTFF2];
}

+(void)changeXTFF1
{
    SEL originalSelector = @selector(encodeWithCoder:);
    SEL swizzledSelector = @selector(cg_encodeWithCoder:);
    
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(self,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        
        //method_setImplementation(originalMethod, method_getImplementation(swizzledMethod));
        class_replaceMethod(self,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}


+(void)changeXTFF2
{
    SEL originalSelector = @selector(initWithCoder:);
    SEL swizzledSelector = @selector(cg_initWithCoder:);
    
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(self,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(self,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}


-(void)cg_encodeWithCoder:(NSCoder *)aCoder
{
    Class tempClass = [self class];
    while (1) {
        u_int count;
        objc_property_t *properties  =class_copyPropertyList(tempClass, &count);
        for (int i = 0; i<count; i++)
        {
            const char* propertyName =property_getName(properties[i]);
            NSString *key = [NSString stringWithUTF8String: propertyName];
            id propertyValue = [self valueForKey:key];
            propertyValue = ([propertyValue isEqual:[NSNull null]] || propertyValue == NULL)?nil:propertyValue;
            [aCoder encodeObject:propertyValue forKey:key];
            
            NSLog(@"%@ -- %@",key,propertyValue);
        }
        free(properties);
        
        
        tempClass = [tempClass superclass];
        if ([NSStringFromClass(tempClass) isEqualToString:@"NSObject"]) {
            break;
        }
    }
}

-(instancetype)cg_initWithCoder:(NSCoder *)aDecoder
{
    if (self) {
        
        Class tempClass = [self class];
        while (1) {
            
            u_int count;
            objc_property_t *properties  =class_copyPropertyList([tempClass class], &count);
            for (int i = 0; i<count; i++)
            {
                const char* propertyName =property_getName(properties[i]);
                NSString *key = [NSString stringWithUTF8String: propertyName];
                id anyobj = [aDecoder decodeObjectForKey:key];
                [self setValue:anyobj forKey:key];
            }
            free(properties);
            
            tempClass = [tempClass superclass];
            if ([NSStringFromClass(tempClass) isEqualToString:@"NSObject"]) {
                break;
            }
        }
    }
    return self;
}
@end
