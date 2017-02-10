//
//  UIView+SwipeBack.m
//  GjFax
//
//  Created by Blavtes on 2017/2/10.
//  Copyright © 2017年 GjFax. All rights reserved.
//

#import "UIView+SwipeBackBlock.h"

static void * SwipeGestureBlockKey = &SwipeGestureBlockKey;

@implementation UIView (SwipeBackBlock)


- (void)addSwipeGestureRecognizerr:(SwipeGestureBlock)handler
{
    objc_setAssociatedObject(self, SwipeGestureBlockKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGesture:)];
    
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self addGestureRecognizer:swipe];
}

-(void)swipeGesture:(UISwipeGestureRecognizer *)btn{
    SwipeGestureBlock block = objc_getAssociatedObject(self, SwipeGestureBlockKey);
    if (block) {
        block();
    }
}
@end
