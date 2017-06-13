//
//  KXActionSheet.h
//  ZhiMaBaoBao
//
//  Created by mac on 16/9/29.
//  Copyright © 2016年 liugang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KXActionSheet;

typedef void(^SetTitleBlock)(UILabel *_titleLabel);

@protocol KXActionSheetDelegate <NSObject>

- (void)KXActionSheet:(KXActionSheet *)sheet andIndex:(NSInteger)index;
- (void)KXActionSheetDidDisappear:(KXActionSheet *)sheet;
@end

@interface KXActionSheet : UIView


@property (nonatomic, weak) id <KXActionSheetDelegate> delegate;

@property (nonatomic, assign) NSInteger flag;

//展示方法
- (void)show;

/**
 构造方法

 @param titleName   标题
 @param delegate    代理
 @param cancelTitle 取消位置
 @param titles      其他按钮（数组形式）
 */
- (instancetype)initWithTitle:(NSString *)titleName
                     delegate:(id <KXActionSheetDelegate>)delegate
                 cancellTitle:(NSString *)cancelTitle
         andOtherButtonTitles:(NSArray *)titles;


/**
 设置标题字体

 @param attributedStr 标题富文本
 */
- (void)setTitleColorWithAttributedStr:(NSMutableAttributedString *)attributedStr;

- (void)setTitleColorWithAttributedStrWithBlock:(SetTitleBlock)block;


/**
 标红字体方法

 @param index 第几行需要标红
 */
- (void)setImportanceTitleAtIndex:(NSUInteger)index;


/**
 给某一行设置文字图片

 @param index       第几行
 @param image       图片
 @param edgInsets   图片距文字的边距
 @param aligment    按钮的编辑方式
 */
- (void)setSubTitleImageWithIndex:(NSUInteger)index
                            image:(UIImage *)image
                  titleEdgeInsets:(UIEdgeInsets)edgInsets
                     WithAligment:(UIControlContentHorizontalAlignment)aligment;






@end
