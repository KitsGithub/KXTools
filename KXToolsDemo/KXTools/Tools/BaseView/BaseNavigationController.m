//
//  BaseNavigationController.m
//  KXTools
//
//  Created by mac on 2017/6/12.
//  Copyright © 2017年 kit. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

//导航栏底部的线
@property (nonatomic, strong) UIView *lineView;

@end

@implementation BaseNavigationController {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置导航栏背景
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"WhiteImage"] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

#pragma mark - open Method
- (void)setBottomLineViewHiden:(BOOL)isHiden {
    self.lineView.hidden = isHiden;
}


#pragma mark - privated Method
//把StatusBar的设置 响应给顶层控制器
- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}


//通过一个方法来找到这个黑线(findHairlineImageViewUnder):
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
        
    }
    
    return nil;
    
}

#pragma mark - lazyLoad
- (UIView *)lineView {
    if (!_lineView) {
        //设置导航栏底线
        UIImageView *navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationBar];
        navBarHairlineImageView.hidden = YES;
        
        _lineView = [[UIView alloc] initWithFrame:navBarHairlineImageView.frame];
        _lineView.backgroundColor = [UIColor colorFormHexRGB:@"e6e7ea"];
        [self.navigationBar addSubview:_lineView];
    }
    return _lineView;
}

@end
