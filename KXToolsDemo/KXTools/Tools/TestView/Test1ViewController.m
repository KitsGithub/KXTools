//
//  Test1ViewController.m
//  KXTools
//
//  Created by mac on 2017/6/12.
//  Copyright © 2017年 kit. All rights reserved.
//

#import "Test1ViewController.h"

#import "Test2ViewController.h"
#import <UIImage+YYAdd.h>


@interface Test1ViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation Test1ViewController {
    CGFloat alpha;
}

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
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    if (alpha > 0) {
        self.navigationController.navigationBar.alpha = alpha;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.alpha = 1;
}

- (void)setupNav {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"测试1";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"跳转" style:UIBarButtonItemStylePlain target:self action:@selector(jumpToNavVc)];
    
    [super setCustomBackItemWihtCustomImage:[UIImage imageNamed:@"NewCircle_Nav_Back"]];
    
    
    
}

- (void)setupView {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonDidClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"123"];
    
    
}



- (void)navSideslipAction {
    NSLog(@"打印");
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"123" forIndexPath:indexPath];
    cell.textLabel.text = @"demo";
    return cell;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    //下拉放大
    if (offsetY == 0) {
        self.navigationController.navigationBar.alpha = 1;
        return;
    }
    
    
    
    //导航栏颜色变换
    if (offsetY > 0) {
        if (offsetY > 0 && offsetY < 200) {
            alpha = 1 - (offsetY  / 200.0);
            self.navigationController.navigationBar.alpha = alpha;
        } else {
            self.navigationController.navigationBar.alpha = 0;
        }
    }
    
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
