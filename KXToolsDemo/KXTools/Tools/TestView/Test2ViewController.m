//
//  Test2ViewController.m
//  KXTools
//
//  Created by mac on 2017/6/12.
//  Copyright © 2017年 kit. All rights reserved.
//

#import "Test2ViewController.h"

@interface Test2ViewController ()

@end

@implementation Test2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupNav {
    BaseNavigationController *baseNav = (BaseNavigationController *)self.navigationController;
    [baseNav setBottomLineViewHiden:YES];
    
    //设置导航栏背景
    [baseNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"WhiteImage"] forBarMetrics:UIBarMetricsDefault];
    
    self.title = @"测试1";
}

@end
