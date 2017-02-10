//
//  NSObject+Extension.h
//
//
//  Created by Blavtes on 15/9/9.
//  Copyright (c) 2015年 Blavtes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)
/**
 *  函数交换
 *
 *  @param origSelector
 *  @param newIMP
 *
 *  @return didAddMethod
 */
+ (BOOL)swizzleSelector:(SEL)originalSEL withSwizzledSelector:(SEL)swizzledSEL;
    
/**
 *  判断一个对象是否为nil
 */
- (BOOL)isNilObj;
@end
