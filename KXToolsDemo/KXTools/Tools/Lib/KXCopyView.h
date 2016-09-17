//
//  KXCopyView.h
//  copyDemo
//
//  Created by mac on 16/9/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    KXCopyViewLoaction_up,
    KXCopyViewLoaction_down
} KXCopyViewLoaction;

@protocol KXCopyViewDelegate <NSObject>

@optional
- (void)KXCopyViewDidClickWithIndex:(NSInteger)index;

@end

@interface KXCopyView : UIView

/**
 *  自定义文字数组
 */
@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, weak) id <KXCopyViewDelegate> delegate;

/**
 *  通过1个已知控制创建一个copyView
 *
 *  @param controler 控件
 *  @param location  展示位置
 *
 *  @return copyView
 */
- (instancetype)initWithControler:(UIView *)controler andLocation:(KXCopyViewLoaction)location;


/**
 *  设置背景图片
 *
 *  @param image  背景图片
 *  @param insets 拉伸图片范围
 */
- (void)setImage:(UIImage *)image andInsets:(UIEdgeInsets)insets;


/**
 *  开始动画
 */
- (void)showAnimation;

/**
 *  结束动画
 */
- (void)endAnimation;

@end
