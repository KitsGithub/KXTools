//
//  KXActionSheet.m
//  ZhiMaBaoBao
//
//  Created by mac on 16/9/29.
//  Copyright © 2016年 liugang. All rights reserved.
//

#import "KXActionSheet.h"

#define ButtonHeight 50

#define TitleTag 100

@implementation KXActionSheet {
    UIButton *_bjView;
    UIView *_buttonView;
    UILabel *_titleLabel;
}

- (instancetype)initWithTitle:(NSString *)titleName cancellTitle:(NSString *)cancelTitle andOtherButtonTitles:(NSArray *)titles {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        [self setupView];
        [self setupButtonWithTitleName:titleName andCancellTitle:cancelTitle andOtherButton:titles];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    return self;
}

- (void)setupView {
    _bjView = [UIButton new];
    _bjView.backgroundColor = [UIColor blackColor];
    _bjView.alpha = 0.0;
    [self addSubview:_bjView];
    [_bjView addTarget:self action:@selector(bjViewDidClick) forControlEvents:UIControlEventTouchUpInside];
}


- (void)setupButtonWithTitleName:(NSString *)titleName andCancellTitle:(NSString *)cancellTitle andOtherButton:(NSArray *)titles {
    NSInteger buttonCount;
    if (([titleName isEqualToString:@""] || titleName == nil) || ([cancellTitle isEqualToString:@""] || cancellTitle == nil)) {
        buttonCount = titles.count + 1;
    } else {
        buttonCount = titles.count + 2;
    }
    
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), ScreenWidth, ButtonHeight * buttonCount + 5)];
    [self addSubview:buttonView];
    _buttonView = buttonView;
    _buttonView.backgroundColor = [UIColor lightGrayColor];
    //标题
    UIView *lastView;
    if (![titleName isEqualToString:@""]) {
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(buttonView.frame), ButtonHeight)];
        _titleLabel = titleLable;
        titleLable.text = titleName;
        titleLable.font = [UIFont systemFontOfSize:12];
        titleLable.textColor = [UIColor lightGrayColor];
        titleLable.backgroundColor = [UIColor whiteColor];
        titleLable.textAlignment = NSTextAlignmentCenter;
        lastView = titleLable;
        [buttonView addSubview:titleLable];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(titleLable.frame) - 0.5, CGRectGetWidth(titleLable.frame), 0.5)];
        lineView.backgroundColor = [UIColor colorFormHexRGB:@"dedede"];
        [buttonView addSubview:lineView];
    }
    
    
    for (NSInteger index = 0; index < titles.count; index++ ) {
        NSString *buttonTitle = titles[index];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lastView.frame), ScreenWidth, ButtonHeight)];
        [buttonView addSubview:button];
        
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        button.tag = index;
        [button addTarget:self action:@selector(titleButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (index != titles.count - 1) {
            UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(button.frame) - 1, CGRectGetWidth(buttonView.frame), 1)];
            bottomLineView.backgroundColor = [UIColor colorFormHexRGB:@"dedede"];
            [buttonView addSubview:bottomLineView];
        }
        
        lastView = button;
    }
    
    if (![cancellTitle isEqualToString:@""]) {
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lastView.frame) + 5 , ScreenWidth, ButtonHeight)];
        [cancelButton setTitle:cancellTitle forState:UIControlStateNormal];
        cancelButton.backgroundColor = [UIColor whiteColor];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancelButton.tag = titles.count;
        [cancelButton addTarget:self action:@selector(titleButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttonView addSubview:cancelButton];
    }
    
}

- (void)show {
    [UIView animateWithDuration:0.3 animations:^{
        _bjView.alpha = 0.3;
        CGFloat height = _buttonView.height;
        _buttonView.frame = CGRectMake(0, ScreenHeight - height, ScreenWidth, height);
    } completion:^(BOOL finished) {
        
    }];
}

//标红字体方法
- (void)setInportanceTitleAtIndex:(NSUInteger)index {
    for (UIButton *targetButton in _buttonView.subviews) {
        if ([targetButton isKindOfClass:[UIButton class]] && targetButton.tag == index) {
            [targetButton setTitleColor:THEMECOLOR forState:UIControlStateNormal];
            break;
        }
    }
}

//设置标题字体
- (void)setTitleColorWithAttributedStr:(NSMutableAttributedString *)attributedStr {
    _titleLabel.attributedText = attributedStr;
}

- (void)setSubTitleImageWithIndex:(NSUInteger)index image:(UIImage *)image titleEdgeInsets:(UIEdgeInsets)edgInsets WithAligment:(UIControlContentHorizontalAlignment)aligment {
    for (UIButton *targetButton in _buttonView.subviews) {
        if ([targetButton isKindOfClass:[UIButton class]] && targetButton.tag == index) {
            [targetButton setImage:image forState:UIControlStateNormal];
            [targetButton setContentHorizontalAlignment:aligment];
            [targetButton setImageEdgeInsets:edgInsets];
            targetButton.titleEdgeInsets = UIEdgeInsetsMake(0, edgInsets.left + 10, 0, 0);
            break;
        }
    }
}


- (void)titleButtonDidClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(KXActionSheet:andIndex:)]) {
        [self.delegate KXActionSheet:self andIndex:sender.tag];
    }
    [self bjViewDidClick];
}


- (void)bjViewDidClick {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0f;
        _buttonView.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), ScreenWidth, _buttonView.height);
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(KXActionSheetDidDisappear:)]) {
            [self.delegate KXActionSheetDidDisappear:self];
        }
        [self removeFromSuperview];
    }];
}


- (void)layoutSubviews {
    _bjView.frame = self.bounds;
}

@end
