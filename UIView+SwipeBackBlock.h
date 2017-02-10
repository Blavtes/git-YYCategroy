//
//  UIView+SwipeBack.h
//  GjFax
//
//  Created by Blavtes on 2017/2/10.
//  Copyright © 2017年 GjFax. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SwipeGestureBlock) ();

@interface UIView (SwipeBackBlock)
- (void)addSwipeGestureRecognizerr:(SwipeGestureBlock)handler;

@end
