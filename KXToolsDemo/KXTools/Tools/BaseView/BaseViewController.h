//
//  BaseViewController.h
//  KXTools
//
//  Created by mac on 2017/6/12.
//  Copyright © 2017年 kit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NavSideslipBlock)();

@interface BaseViewController : UIViewController


/**
 当用户在侧滑的时候就会触发的方法
 */
- (void)navSideslipAction;


/**
 自定义返回按钮

 @param image 返回按钮的图片
 */
- (void)setCustomBackItemWihtCustomImage:(UIImage *)image;

@end
