//
//  NSObject+Extension.m
//
//
//  Created by Blavtes on 15/9/9.
//  Copyright (c) 2015年 Blavtes. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>

@implementation NSObject (Extension)
#pragma mark - 函数交换
+ (BOOL)swizzleSelector:(SEL)originalSEL withSwizzledSelector:(SEL)swizzledSEL
{
    //DLog(@"swizzleSelector in class[%@]", [self class]);
    //  获取目标类
    Class aClass = [self class];
    // When swizzling a class method, use the following:
    // Class class = object_getClass((id)self);
    
    //  获取SEL 及 Method
    SEL originalSelector = originalSEL;
    SEL swizzledSelector = swizzledSEL;
    
    Method originalMethod = class_getInstanceMethod(aClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(aClass, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(aClass,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        //  替换
        class_replaceMethod(aClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        //  交换
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
    return didAddMethod;
}

#pragma mark - 空对象判断

- (BOOL)isNilObj
{
    //  判断value是否为空
    //  1.空对象指针nil
    //  2.空类指针Nil
    //  3.空对象[NSNull null]<非nil> - 不会造成容器崩溃
    //  4.空基本数据类型NULL
    //  5.空类[NSNull class]
    if ([self isEqual:[NSNull null]] || nil == self || Nil == self || NULL == self) {
        //DLog(@"isNilObj - nil obj");
        return YES;
    } else if ([self isKindOfClass:[NSNull class]]) {
        //DLog(@"isNilObj - nil class");
        return YES;
    } else if ([self isKindOfClass:[NSString class]] && FMT_STR(@"%@", self).length <= 0) {
        //DLog(@"isNilObj - self is NSString && length <= 0");
        return YES;
    } else if ([FMT_STR(@"%@", self) isEqualToString:@"(null)"] || [FMT_STR(@"%@", self) isEqualToString:@"<null>"]) {
        //  服务器返回的特殊空字符
        return YES;
    }
    
    return NO;
}
@end
