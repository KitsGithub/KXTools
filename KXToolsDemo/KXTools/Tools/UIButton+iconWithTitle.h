//
//  UIButton+iconWithTitle.h
//  ZDShops
//
//  Created by zh on 16/4/6.
//  Copyright © 2016年 kit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    KXCustomButtonHorizontalType = 0,  /** 水平样式  */
    KXCustomButtonVerticalType = 1,    /** 垂直样式   */
} kXCustomButtonType;

@interface UIButton (iconWithTitle)

/**
 *  图片 - 普通状态
 */
@property (nonatomic, weak) UIImageView *KXIconView;

/**
 *  副标题 - 普通状态
 */
@property (nonatomic, weak) UILabel *KXSubTitleLabel;

/**
 *  图片 - 选择状态
 */
@property (nonatomic, weak) UIImageView *KXSelectedIconView;

/**
 *  副标题 - 选择状态
 */
@property (nonatomic, weak) UILabel *KXSelectedSubTitleLabel;


/**
 * 创建1个自定义按钮
 * type = KXCustomButtonHorizontalType 水平样式
 * type = KXCustomButtonVerticalType 垂直样式
 */
- (void)setImage:(UIImage *)image withSize:(CGSize)imageSize  andSubTtitle:(NSString *)subTitle andFont:(CGFloat)fontSize withType:(kXCustomButtonType)type stata:(UIControlState)state;

/** 设置副标题的对齐方式 */
- (void)setKXSubTitleLabelTextAlignment:(NSTextAlignment)Alignment;



@end
