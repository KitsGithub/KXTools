//
//  UIButton+iconWithTitle.m
//  ZDShops
//
//  Created by zh on 16/4/6.
//  Copyright © 2016年 kit. All rights reserved.
//

#import "UIButton+iconWithTitle.h"
#import <objc/runtime.h>

static char KXNormalIcon;
static char KXNormalTitle;
static char KXSelectedIcon;
static char KXSelectedTitle;

@interface UIButton ()


@end

@implementation UIButton (iconWithTitle)


- (void)setImage:(UIImage *)image withSize:(CGSize)imageSize andSubTtitle:(NSString *)subTitle andFont:(CGFloat)fontSize withType:(kXCustomButtonType)type stata:(UIControlState)state{
    
    switch (type) {
        case KXCustomButtonHorizontalType:  //水平样式
            [self setHorizontalTypeButtonWithImage:image withSize:imageSize andSubTtitle:subTitle andFont:fontSize state:state];
            break;
        case KXCustomButtonVerticalType:    //垂直样式
            [self setVerticalTypeButtonWithImage:image withSize:imageSize andSubTtitle:subTitle andFont:fontSize state:state];
            break;
        default:
            break;
    }
    //监听selected
    [self addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:nil];
}

/** 创建1个图片在上，副标题在下 的样式的按钮 */
- (void)setVerticalTypeButtonWithImage:(UIImage *)image withSize:(CGSize)imageSize  andSubTtitle:(NSString *)subTitle andFont:(CGFloat)fontSize state:(UIControlState)state {
    
    if (state == UIControlStateNormal) {  //普通状态
        UIImageView *iconView = [[UIImageView alloc] init];
        self.KXIconView = iconView;
        iconView.image = image;
        [self addSubview:iconView];
        
        UILabel *subTitleLabel = [[UILabel alloc] init];
        self.KXSubTitleLabel = subTitleLabel;
        subTitleLabel.text = subTitle;
        subTitleLabel.textAlignment = NSTextAlignmentCenter;
        subTitleLabel.font = [UIFont systemFontOfSize:fontSize];
        [self addSubview:subTitleLabel];
        
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        
        CGFloat iconW = imageSize.width;
        CGFloat iconH = imageSize.height;
        CGFloat iconX = (width - iconW) * 0.5;
        CGFloat iconY = (height - iconH) * 0.5 - iconH * 0.5;
        iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
        
        subTitleLabel.frame = CGRectMake(0, CGRectGetMaxY(iconView.frame) + 10, width, 20);
        
    }
    else if (state == UIControlStateSelected) {  //选择状态
        
        UIImageView *selectedIcon = [[UIImageView alloc] init];
        self.KXSelectedIconView = selectedIcon;
        selectedIcon.image = image;
        [self addSubview:selectedIcon];
        
        UILabel *selectedLabel = [[UILabel alloc] init];

        self.KXSelectedSubTitleLabel = selectedLabel;
        selectedLabel.text = subTitle;
        selectedLabel.textAlignment = NSTextAlignmentCenter;
        selectedLabel.font = [UIFont systemFontOfSize:fontSize];
        [self addSubview:selectedLabel];
        
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        
        CGFloat iconW = imageSize.width;
        CGFloat iconH = imageSize.height;
        CGFloat iconX = (width - iconW) * 0.5;
        CGFloat iconY = (height - iconH) * 0.5 - iconH * 0.5;
        selectedIcon.frame = CGRectMake(iconX, iconY, iconW, iconH);
        selectedLabel.frame = CGRectMake(0, CGRectGetMaxY(selectedIcon.frame) + 10, width, 20);
        
        //隐藏选择状态文本
        selectedLabel.hidden = YES;
        selectedLabel.alpha = 0.0f;

        //隐藏选择状态图片
        self.KXSelectedIconView.hidden = YES;
        self.KXSelectedIconView.alpha = 0.0f;
    }
    
}

/** 创建1个图片在左，副标题在右 的样式的按钮 */
- (void)setHorizontalTypeButtonWithImage:(UIImage *)image withSize:(CGSize)imageSize  andSubTtitle:(NSString *)subTitle andFont:(CGFloat)fontSize state:(UIControlState)state {
    
    if (state == UIControlStateNormal) {
        UIImageView *iconView = [[UIImageView alloc] init];
        self.KXIconView = iconView;
        iconView.image = image;
        [self addSubview:iconView];
        
        UILabel *subTitleLabel = [[UILabel alloc] init];
        self.KXSubTitleLabel = subTitleLabel;
        subTitleLabel.text = subTitle;
        subTitleLabel.textAlignment = NSTextAlignmentCenter;
        subTitleLabel.font = [UIFont systemFontOfSize:fontSize];
        [self addSubview:subTitleLabel];
        
        CGFloat height = self.frame.size.height;
        
        CGFloat iconX = 0;
        CGFloat iconY = (height - imageSize.height )* 0.5;
        CGFloat iconW = imageSize.width;
        CGFloat iconH = imageSize.height;
        self.KXIconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
        
        
        CGFloat subTitleX = CGRectGetMaxX(self.KXIconView.frame);
        CGFloat subTitleY = 0;
        CGFloat sbuTitleW = CGRectGetWidth(self.frame) - subTitleX;
        CGFloat subTitleH = CGRectGetHeight(self.frame);
        self.KXSubTitleLabel.frame = CGRectMake(subTitleX, subTitleY, sbuTitleW, subTitleH);

    }
    else if (state == UIControlStateSelected) {
        UIImageView *selectedIcon = [[UIImageView alloc] init];
        self.KXSelectedIconView = selectedIcon;
        self.KXSelectedIconView.image = image;
        [self addSubview:selectedIcon];
        
        UILabel *selectedLabel = [[UILabel alloc] init];
        self.KXSelectedSubTitleLabel = selectedLabel;
        selectedLabel.text = subTitle;
        selectedLabel.textAlignment = NSTextAlignmentCenter;
        selectedLabel.font = [UIFont systemFontOfSize:fontSize];
        [self addSubview:selectedLabel];
        
        
        CGFloat height = self.frame.size.height;
        
        CGFloat iconX = 0;
        CGFloat iconY = (height - imageSize.height )* 0.5;
        CGFloat iconW = imageSize.width;
        CGFloat iconH = imageSize.height;
        self.KXSelectedIconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
        
        
        CGFloat subTitleX = CGRectGetMaxX(self.KXIconView.frame);
        CGFloat subTitleY = 0;
        CGFloat sbuTitleW = CGRectGetWidth(self.frame) - subTitleX;
        CGFloat subTitleH = CGRectGetHeight(self.frame);
        self.KXSelectedSubTitleLabel.frame = CGRectMake(subTitleX, subTitleY, sbuTitleW, subTitleH);
        
        //隐藏选择状态文本
        selectedLabel.hidden = YES;
        selectedLabel.alpha = 0.0f;
        
        //隐藏选择状态图片
        selectedIcon.hidden = YES;
        selectedIcon.alpha = 0.0f;

    }
    
}


- (void)setKXSubTitleLabelTextAlignment:(NSTextAlignment)Alignment {
    self.KXSubTitleLabel.textAlignment = Alignment;
}

//kvo监听按钮的选择状态
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if (self.selected) {
        [self setSelectedSate:NO];
        [self setNormalStata:YES];
    } else {
        [self setSelectedSate:YES];
        [self setNormalStata:NO];
    }
}

//设置 选择状态的控件
- (void)setSelectedSate:(BOOL)selected {
    CGFloat alpha = 0.0;
    if (selected) {
        alpha = 0.0f;
    } else {
        alpha = 1.0f;
    }
    self.KXSelectedSubTitleLabel.hidden = selected;
    self.KXSelectedSubTitleLabel.alpha = alpha;
    self.KXSelectedIconView.hidden = selected;
    self.KXSelectedIconView.alpha = alpha;
}

//设置 普通状态的控件
- (void)setNormalStata:(BOOL)normal {
    CGFloat alpha = 0.0f;
    if (normal) {
        alpha = 0.0f;
    } else {
        alpha = 1.0f;
    }
    
    self.KXIconView.hidden = normal;
    self.KXIconView.alpha = alpha;
    self.KXSubTitleLabel.hidden = normal;
    self.KXSubTitleLabel.alpha = alpha;
    
}


#pragma mark - lazyLoad
//设置IconView
- (void)setKXIconView:(UIImageView *)KXIconView{
    objc_setAssociatedObject(self, &KXNormalIcon, KXIconView, OBJC_ASSOCIATION_RETAIN);
}
- (UIImageView *)KXIconView {
    return objc_getAssociatedObject(self, &KXNormalIcon);
}

//设置subTitleLabel
- (void)setKXSubTitleLabel:(UILabel *)KXSubTitleLabel {
    objc_setAssociatedObject(self, &KXNormalTitle, KXSubTitleLabel, OBJC_ASSOCIATION_RETAIN);
}

- (UILabel *)KXSubTitleLabel {
    return  objc_getAssociatedObject(self, &KXNormalTitle);
}

//设置选择状态的iconView
- (void)setKXSelectedIconView:(UIImageView *)KXSelectedIconView {
    objc_setAssociatedObject(self, &KXSelectedIcon, KXSelectedIconView, OBJC_ASSOCIATION_RETAIN);
}

- (UIImageView *)KXSelectedIconView {
    return objc_getAssociatedObject(self, &KXSelectedIcon);
}

//设置选择状态的title
- (void)setKXSelectedSubTitleLabel:(UILabel *)KXSelectedSubTitleLabel {
    objc_setAssociatedObject(self, &KXSelectedTitle, KXSelectedSubTitleLabel, OBJC_ASSOCIATION_RETAIN);
}

- (UILabel *)KXSelectedSubTitleLabel  {
    return objc_getAssociatedObject(self, &KXSelectedTitle);
}



- (void)dealloc {
    [self removeObserver:self forKeyPath:@"selected"];
}


@end
