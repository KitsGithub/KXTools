//
//  Test1ViewController.m
//  KXTools
//
//  Created by mac on 2017/6/12.
//  Copyright © 2017年 kit. All rights reserved.
//

#import "Test1ViewController.h"

@interface Test1ViewController ()

@end

@implementation Test1ViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"测试1";
    
    //设置导航栏背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"PurpleImage"] forBarMetrics:UIBarMetricsDefault];
}

@end
