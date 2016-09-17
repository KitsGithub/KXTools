//
//  UILabel+kxPrice.m
//  KXTools
//
//  Created by kit on 16/4/22.
//  Copyright © 2016年 kit. All rights reserved.
//

#import "UILabel+kxPrice.h"
#import "NSString+FontSize.h"
#import <objc/runtime.h>

@implementation UILabel (kxPrice)
static char priceKey;
static char priceColorKey;
static char unitKey;
static char unitColorKey;

- (instancetype)initWithPrice:(CGFloat)price andUnit:(NSString *)unit {
    self = [super init];
    if (self) {
        self.price = [NSString stringWithFormat:@"%lf",price];
        self.unit = unit;
        [self setupLabel];
    }
    return self;
}

- (void)titleWithPrice:(CGFloat)price withPirceColor:(UIColor *)priceColor andUnit:(NSString *)unit withUnitColor:(UIColor *)unitColor {
    self.price = [NSString stringWithFormat:@"%.0f",price];
    self.unit = unit;
    self.unitColor = unitColor;
    self.priceColor = priceColor;
    [self setupLabel];
}


- (void)setupLabel {
    
    for (UILabel *label in self.subviews) {
        if ([label isKindOfClass:[UILabel class]]) {
            [label removeFromSuperview];
        }
    }
    
    CGSize priceSize = [self.price sizeWithFont:[UIFont systemFontOfSize:20] maxSize:CGSizeMake(self.frame.size.width * 0.5, self.frame.size.height)];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, priceSize.width, priceSize.height)];
    priceLabel.font = [UIFont systemFontOfSize:20];
    if (self.priceColor) {
        priceLabel.textColor = self.priceColor;
    }
    
    priceLabel.text = self.price;
    [self addSubview: priceLabel];
    
    UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX( priceLabel.frame), CGRectGetMaxY( priceLabel.frame) - 20, 30, 20)];
    unitLabel.font = [UIFont systemFontOfSize:11];
    if (self.unitColor) {
        unitLabel.textColor = self.unitColor;
    }
    
    unitLabel.text = self.unit;
    [self addSubview: unitLabel];
    
    
}




#pragma mark - property
//价格
- (NSString *)price {
    return objc_getAssociatedObject(self, &priceKey);
}

- (void)setPrice:(NSString *)price {
    objc_setAssociatedObject(self, &priceKey, price, OBJC_ASSOCIATION_COPY);
}

//价格颜色
- (UIColor *)priceColor {
    return objc_getAssociatedObject(self, &priceColorKey);
}

- (void)setPriceColor:(UIColor *)priceColor {
    objc_setAssociatedObject(self, &priceColorKey, priceColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//单位
- (NSString *)unit {
    return objc_getAssociatedObject(self, &unitKey);
}

- (void)setUnit:(NSString *)unit {
    objc_setAssociatedObject(self, &unitKey, unit, OBJC_ASSOCIATION_COPY);
}

//单位颜色
- (UIColor *)unitColor {
    return objc_getAssociatedObject(self, &unitColorKey);
}

- (void)setUnitColor:(UIColor *)unitColor {
    objc_setAssociatedObject(self, &unitColorKey, unitColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
