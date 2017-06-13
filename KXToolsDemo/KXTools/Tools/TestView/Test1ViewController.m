//
//  Test1ViewController.m
//  KXTools
//
//  Created by mac on 2017/6/12.
//  Copyright © 2017年 kit. All rights reserved.
//

#import "Test1ViewController.h"

#import "Test2ViewController.h"

@interface Test1ViewController ()

@end

@implementation Test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor yellowColor];
    //设置导航栏背景
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    
}

- (void)setupNav {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"测试1";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"跳转" style:UIBarButtonItemStylePlain target:self action:@selector(jumpToNavVc)];
}

- (void)setupView {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonDidClick) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - privited Mothod

//跳转到一个有导航栏的界面
- (void)jumpToNavVc {
    Test2ViewController *VC = [[Test2ViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)buttonDidClick {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
