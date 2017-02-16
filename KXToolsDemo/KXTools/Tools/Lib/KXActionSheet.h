//
//  KXActionSheet.h
//  ZhiMaBaoBao
//
//  Created by mac on 16/9/29.
//  Copyright © 2016年 liugang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KXActionSheet;
@protocol KXActionSheetDelegate <NSObject>

- (void)KXActionSheet:(KXActionSheet *)sheet andIndex:(NSInteger)index;
- (void)KXActionSheetDidDisappear:(KXActionSheet *)sheet;
@end

@interface KXActionSheet : UIView


@property (nonatomic, weak) id <KXActionSheetDelegate> delegate;

@property (nonatomic, assign) NSInteger flag;

//展示方法
- (void)show;

//构造方法
- (instancetype)initWithTitle:(NSString *)titleName cancellTitle:(NSString *)cancelTitle andOtherButtonTitles:(NSArray *)titles;

//标红字体方法
- (void)setInportanceTitleAtIndex:(NSUInteger)index;

//设置文字图片
- (void)setSubTitleImageWithIndex:(NSUInteger)index image:(UIImage *)image titleEdgeInsets:(UIEdgeInsets)edgInsets  WithAligment:(UIControlContentHorizontalAlignment)aligment;

//设置标题字体
- (void)setTitleColorWithAttributedStr:(NSMutableAttributedString *)attributedStr;




@end
