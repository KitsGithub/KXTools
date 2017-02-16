//
//  KXAlertView.m
//  ZhiMaBaoBao
//
//  Created by mac on 16/11/28.
//  Copyright © 2016年 liugang. All rights reserved.
//

#import "KXAlertView.h"
#import "MLLinkLabel.h"

static NSInteger buttonHeight = 45;
static NSUInteger alertViewWidth = 0;

@interface KXAlertView () <MLLinkLabelDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) MLLinkLabel *messageLabel;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *subTitleButton;

@end

@implementation KXAlertView {
    UIButton *_bjView;
    UIView *_alertView;
    UIView *_topLineView;
    UIView *_rightLineView;
    UIView *_titleLineView;
}

- (instancetype)initWithTitle:(NSString *)title andMessage:(NSString *)message andCancelButton:(NSString *)cancel andSubTitle:(NSString *)andSubTitle {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        [self setupView];
        [self setupAlertViewWithTitle:title andMessage:message andCancelButton:cancel andSubTitle:andSubTitle];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    return self;
}

- (void)setupView {
    _bjView = [UIButton new];
    _bjView.backgroundColor = [UIColor blackColor];
    _bjView.alpha = 0.0;
    [self addSubview:_bjView];
//    [_bjView addTarget:self action:@selector(bjViewDidClick) forControlEvents:UIControlEventTouchUpInside];
}


- (void)setupAlertViewWithTitle:(NSString *)title andMessage:(NSString *)message andCancelButton:(NSString *)cancel andSubTitle:(NSString *)subTitle {
    
    _alertView = [UIView new];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.layer.cornerRadius = 14;
    [self addSubview:_alertView];
    
    if (title.length) {
        self.titleLabel.text = title;
        _titleLineView = [UIView new];
        _titleLineView.backgroundColor = [UIColor colorFormHexRGB:@"d9d9d9"];
        [_alertView addSubview:_titleLineView];
    }
    
    if (message.length) {
        self.messageLabel.text = message;
    }
    
    if (cancel.length) {
        [self.cancelButton setTitle:cancel forState:UIControlStateNormal];
    }
    
    if (subTitle.length) {
        [self.subTitleButton setTitle:subTitle forState:UIControlStateNormal];
    }
    
    
    
    _topLineView = [UIView new];
    _topLineView.backgroundColor = [UIColor colorFormHexRGB:@"d9d9d9"];
    [_alertView addSubview:_topLineView];
    
    _rightLineView = [UIView new];
    _rightLineView.backgroundColor = [UIColor colorFormHexRGB:@"d9d9d9"];
    [_alertView addSubview:_rightLineView];
}

- (void)setSpacialLinkWithTargetStr:(NSString *)targetStr {
    MLLink *link = [MLLink linkWithType:MLLinkTypeOther value:targetStr range:[_messageLabel.text rangeOfString:targetStr]];
    link.linkTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorFormHexRGB:@"007aff"]};
    [_messageLabel addLink:link];
}

- (void)didClickLink:(MLLink*)link linkText:(NSString*)linkText linkLabel:(MLLinkLabel*)linkLabel {
    [self hidenAnimation];
    if ([self.delegate respondsToSelector:@selector(KXAlertView:ClickSpacialLinkWithLinkValue:)]) {
        [self.delegate KXAlertView:self ClickSpacialLinkWithLinkValue:link.linkValue];
    }
}


- (void)show {
    [UIView animateWithDuration:0.3 animations:^{
        _bjView.alpha = 0.3;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hidenAnimation {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)layoutSubviews {
    _bjView.frame = self.bounds;
    alertViewWidth = CGRectGetWidth(self.frame) - 70;
    CGFloat height = 150; //预高度为150
    _alertView.frame = CGRectMake(self.center.x - alertViewWidth * 0.5, self.center.y - 150 * 0.5, alertViewWidth, height);
    
    CGFloat padding = 10;
    
    if (_titleLabel) {
        _titleLabel.frame = CGRectMake(0, padding, CGRectGetWidth(_alertView.frame), 20);
        _titleLineView.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame) + 5, alertViewWidth, 0.5);
    }
    
    if (_messageLabel) {
        CGFloat messageHeight;
        if (ScreenWidth >= 375) {
            //iPhone 6 以上 屏幕
            messageHeight = [_messageLabel.text sizeWithFont:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(alertViewWidth - 20, MAXFLOAT)].height;
        } else {
            //iPhone 5 屏幕
            messageHeight = [_messageLabel.text sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(alertViewWidth - 20, MAXFLOAT)].height;
        }
        _messageLabel.frame = CGRectMake(padding, CGRectGetMaxY(_titleLineView.frame) + padding , alertViewWidth - padding * 2, messageHeight);
    }
    
    _topLineView.frame = CGRectMake(0, CGRectGetMaxY(_messageLabel.frame) + padding , alertViewWidth, 0.5);
    
    if (_subTitleButton) {
        //有subTitle
        _subTitleButton.frame = CGRectMake(0, CGRectGetMaxY(_topLineView.frame), alertViewWidth * 0.5, buttonHeight);
        _cancelButton.frame = CGRectMake(CGRectGetMaxX(_subTitleButton.frame), CGRectGetMaxY(_topLineView.frame), CGRectGetWidth(_alertView.frame) * 0.5, buttonHeight);
        _rightLineView.frame = CGRectMake(CGRectGetMaxX(_subTitleButton.frame), CGRectGetMinY(_subTitleButton.frame), 1, buttonHeight);
    } else if (_cancelButton){
        //没有subTitle
        _cancelButton.frame = CGRectMake(0, CGRectGetMaxY(_topLineView.frame), alertViewWidth , buttonHeight);
    }
    
    
    
    _alertView.frame = CGRectMake(_alertView.frame.origin.x, _alertView.frame.origin.y - (CGRectGetHeight(_alertView.frame) - CGRectGetMaxY(_cancelButton.frame)) * 0.5, alertViewWidth, CGRectGetMaxY(_cancelButton.frame));
    
}

- (void)cancelButtonDidClick:(UIButton *)sender {
    [self hidenAnimation];
    if ([self.delegate respondsToSelector:@selector(KXAlertView:ClickIndex:)]) {
        [self.delegate KXAlertView:self ClickIndex:1];
    }
}

- (void)subTitleButtonDidClick:(UIButton *)sender {
    [self hidenAnimation];
    if ([self.delegate respondsToSelector:@selector(KXAlertView:ClickIndex:)]) {
        [self.delegate KXAlertView:self ClickIndex:0];
    }
}

#pragma mark - lazyLoad 
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.textColor = [UIColor blackColor];
        [_alertView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[MLLinkLabel alloc] init];
        _messageLabel.delegate = self;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.numberOfLines = 0;
        if (ScreenWidth >= 375) {
            _messageLabel.font = [UIFont systemFontOfSize:16];
        } else {
            _messageLabel.font = [UIFont systemFontOfSize:14];
        }
        _messageLabel.textColor = [UIColor blackColor];
        [_alertView addSubview:_messageLabel];
    }
    return _messageLabel;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        NSLog(@"%lf",ScreenWidth);
        if (ScreenWidth >= 375) {
            _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        } else {
            _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        }
        [_alertView addSubview:_cancelButton];
    }
    return _cancelButton;
}

- (UIButton *)subTitleButton {
    if (!_subTitleButton) {
        _subTitleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_subTitleButton setTitleColor:[UIColor colorFormHexRGB:@"007aff"] forState:UIControlStateNormal];
        [_subTitleButton addTarget:self action:@selector(subTitleButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];

        if (ScreenWidth >= 375) {
            //iPhone 6 以上 屏幕
            _subTitleButton.titleLabel.font = [UIFont systemFontOfSize:15];
        } else {
            //iPhone 5 屏幕
            _subTitleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        }
        [_alertView addSubview:_subTitleButton];
    }
    return _subTitleButton;
}


@end
