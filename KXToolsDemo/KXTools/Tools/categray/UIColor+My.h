//
//  UIColor+My.h
//  My00
//
//  Created by 黄杰 on 15/1/27.
//  Copyright (c) 2015年 黄杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (My)
/*!
 * @method 通过16进制计算颜色
 * @abstract
 * @discussion
 * @param 16机制
 * @result 颜色对象
 */
+ (UIColor *)colorFormHexRGB:(NSString *)inColorString;
@end
