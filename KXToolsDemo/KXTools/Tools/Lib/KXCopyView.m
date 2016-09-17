//
//  KXCopyView.m
//  copyDemo
//
//  Created by mac on 16/9/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "KXCopyView.h"

@interface KXCopyView ()

@property (nonatomic, strong) NSMutableArray *buttonArray;
@end

@implementation KXCopyView {
    UIImageView *_BJImageView;
}

/**
 *  通过此方法创建1个copyView
 *
 *  @param controler 设置copyView 需要放在哪个控件上
 *
 *  @return copyView
 */
- (instancetype)initWithControler:(UIView *)control andLocation:(KXCopyViewLoaction)location{
    
    //获取控件相对于window的位置
    CGRect controlFrame = [control convertRect:control.frame toView:[UIApplication sharedApplication].keyWindow];
    
    CGRect selfFrame = [self getFrameWithLoaction:location andFrame:controlFrame];
    if (self = [super initWithFrame:selfFrame]) {
        self.alpha = 0.0f;
    }
    return self;
}


- (CGRect)getFrameWithLoaction:(KXCopyViewLoaction)location andFrame:(CGRect)frame {
    CGRect selfFrame = CGRectZero;
    CGFloat selfHight = 40;
    CGFloat selfWidth = 100;
    switch (location) {
        case KXCopyViewLoaction_up: {
            selfFrame = CGRectMake((frame.origin.x + frame.size.width * 0.5) - selfWidth * 0.5, frame.origin.y - selfHight, selfWidth, selfHight);
            break;
        }
        case KXCopyViewLoaction_down: {
            selfFrame = CGRectMake((frame.origin.x + frame.size.width * 0.5) - selfWidth * 0.5, CGRectGetMaxY(frame) , selfWidth, selfHight);
            break;
        }
        default:
            break;
    }
    return selfFrame;
}


- (void)setImage:(UIImage *)image andInsets:(UIEdgeInsets)insets {
    
    _BJImageView = [[UIImageView alloc] init];
    _BJImageView.image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    _BJImageView.userInteractionEnabled = YES;
    [self addSubview:_BJImageView];
}

- (void)setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        UIButton *label = [UIButton new];
        label.tag = index;
        label.titleLabel.textAlignment = NSTextAlignmentCenter;
        label.titleLabel.textColor = [UIColor whiteColor];
        label.titleLabel.font = [UIFont systemFontOfSize:13];
        [label setTitle:titleArray[index] forState:UIControlStateNormal];
        [self addSubview:label];
        [self.buttonArray addObject:label];
        
        [label addTarget:self action:@selector(labelDidClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}


- (void)labelDidClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(KXCopyViewDidClickWithIndex:)]) {
        [self.delegate KXCopyViewDidClickWithIndex:sender.tag];
    }
}


- (void)showAnimation {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0f;
    }];
}

- (void)endAnimation {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0f;
        [self removeFromSuperview];
    }];
}

- (void)layoutSubviews {
    _BJImageView.frame = self.bounds;
    
    CGFloat labelWidth = CGRectGetWidth(self.frame) / self.buttonArray.count;
    CGFloat labelHeight = CGRectGetHeight(self.frame) - 10;
    for (NSInteger index = 0; index < self.buttonArray.count; index++) {
        UIButton *button = self.buttonArray[index];
        button.frame = CGRectMake(labelWidth * index, 0, labelWidth, labelHeight);
        [self bringSubviewToFront:button];
    }
}

#pragma mark - lazyLoad
- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

@end
