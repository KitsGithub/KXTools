//
//  ViewController.m
//  KXTools
//
//  Created by kit on 16/4/22.
//  Copyright © 2016年 kit. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+iconWithTitle.h"
#import "KXCodingManager.h"

#import "KXCopyView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:button];
    [button setImage:[UIImage imageNamed:@"textIcon_00"] withSize:CGSizeMake(44, 44) andSubTtitle:@"测试按钮" andFont:13 withType:KXCustomButtonVerticalType stata:UIControlStateNormal];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 120, 44)];
    [self.view addSubview:button2];
    [button2 setImage:[UIImage imageNamed:@"BecomeSeller_emty"] withSize:CGSizeMake(20, 20) andSubTtitle:@"测试按钮2" andFont:17 withType:KXCustomButtonHorizontalType stata:UIControlStateNormal];
    
    [button2 setImage:[UIImage imageNamed:@"BecomeSeller_tick"] withSize:CGSizeMake(20, 20) andSubTtitle:@"测试按钮2" andFont:17 withType:KXCustomButtonHorizontalType stata:UIControlStateSelected];
    
    [button2 setKXSubTitleLabelTextAlignment:NSTextAlignmentCenter];
    button2.KXSubTitleLabel.textColor = [UIColor blackColor];
    button2.KXSelectedSubTitleLabel.textColor = [UIColor redColor];
    [button2 addTarget:self action:@selector(buttonStatusChange:) forControlEvents:UIControlEventTouchUpInside];
    
    
    KXCopyView *copyView = [[KXCopyView alloc] initWithControler:button andLocation:KXCopyViewLoaction_up];
    copyView.titleArray = @[@"复制",@"粘贴"];
    [copyView setImage:[UIImage imageNamed:@"Discovre_Copy"] andInsets:UIEdgeInsetsMake(30, 40, 30, 40)];
    
    [self.view addSubview:copyView];
    [copyView showAnimation];
    
    
    KXCodingManager *manager = [[KXCodingManager alloc] initWithSequreKey:@"yihezhai16816888"];
    
    NSString *encodingStr = [manager base64Encoding:@"我爱你"];
    NSLog(@"base64编码后的内容: %@",encodingStr);
    
    NSString *decodingStr = [manager base64Decoding:encodingStr];
    NSLog(@"base64解码后的内容: %@",decodingStr);
    
    
    NSString *AESEncodingStr = [manager AESEncoding:@"我爱你"];
    NSLog(@"AES加密之后的内容: %@",AESEncodingStr);
    
    
    NSString *AESDecodingStr = [manager AESDecoding:AESEncodingStr];
    NSLog(@"AES解密之后的内容: %@",AESDecodingStr);
    
    //如果私钥不一样，则会创建1个新的manger对象，请注意使用，
    // initWithSequreKey 只会取出第一次创建的对象，
    // 这个问题待修复
    KXCodingManager *manager2 = [[KXCodingManager alloc] initWithSequreKey:@"123123"];
    NSLog(@"%@",manager.SequreKey);
    NSLog(@"%@",manager2.SequreKey);

}

- (void)buttonStatusChange:(UIButton *)sender {
    NSLog(@"换了");
    sender.selected = !sender.selected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
