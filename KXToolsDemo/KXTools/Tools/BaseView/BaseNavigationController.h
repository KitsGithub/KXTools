//
//  BaseNavigationController.h
//  KXTools
//
//  Created by mac on 2017/6/12.
//  Copyright © 2017年 kit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController

/**
 设置NavBar底部线条是否隐藏

 @param isHiden 是否隐藏
 */
- (void)setBottomLineViewHiden:(BOOL)isHiden;

/**
 设置NavBar底部线条的颜色

 @param color 颜色
 */
- (void)setBottomLineViewColor:(UIColor *)color;

@end
