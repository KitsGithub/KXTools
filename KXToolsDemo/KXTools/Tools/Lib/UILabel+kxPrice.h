//
//  UILabel+kxPrice.h
//  KXTools
//
//  Created by kit on 16/4/22.
//  Copyright © 2016年 kit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (kxPrice)
@property (nonatomic, copy) NSString *price; /** 价格文本*/
@property (nonatomic, copy) NSString *unit;   /** 单位文本*/
@property (nonatomic, weak) UIColor *priceColor;  /** 价格颜色*/
@property (nonatomic, weak) UIColor *unitColor;    /** 单位颜色*/


/**
 *  设置1个带有单位的Label 默认黑色
 *
 *  @param price 价格
 *  @param unit  单位
 *
 *  @return 返回1个Label
 */
- (instancetype)initWithPrice:(CGFloat)price andUnit:(NSString *)unit;

/**
 *  设置1个带有单位的label
 *
 *  @param price      价格
 *  @param priceColor 价格文本的颜色
 *  @param unit       单位
 *  @param unitColor  单位文本的颜色
 */
- (void)titleWithPrice:(CGFloat)price withPirceColor:(UIColor *)priceColor andUnit:(NSString *)unit withUnitColor:(UIColor *)unitColor;
@end
