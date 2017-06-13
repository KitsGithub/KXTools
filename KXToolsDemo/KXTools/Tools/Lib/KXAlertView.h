//
//  KXAlertView.h
//  ZhiMaBaoBao
//
//  Created by mac on 16/11/28.
//  Copyright © 2016年 liugang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KXAlertView;
@protocol KXAlertViewDelegate <NSObject>

@optional

/**
 取消、确定的点击代理

 @param index Index (1:其他按钮 0:取消按钮)
 */
- (void)KXAlertView:(KXAlertView *)alertView ClickIndex:(NSUInteger)index;

/**
 如果设置了特殊点击效果，当点击目标本文的时候，就会调用此代理

 @param linkValue 目标文本的值
 */
- (void)KXAlertView:(KXAlertView *)alertView ClickSpacialLinkWithLinkValue:(NSString *)linkValue;

@end

@interface KXAlertView : UIView

@property (nonatomic, weak) id <KXAlertViewDelegate> delegate;

/**
 初始化方法

 @param title       标题
 @param message     提示
 @param cancel      取消按钮
 @param andSubTitle 另外一个按钮

 @return 实例化对象
 */
- (instancetype)initWithTitle:(NSString *)title
                   andMessage:(NSString *)message
                     delegate:(id <KXAlertViewDelegate>)delegate
              andCancelButton:(NSString *)cancel
                  andSubTitle:(NSString *)andSubTitle;


/**
 设置提示文本中的特殊的点击效果

 @param targetStr 目标文本
 */
- (void)setSpacialLinkWithTargetStr:(NSString *)targetStr;


/**
 展示动画
 */
- (void)show;
@end
