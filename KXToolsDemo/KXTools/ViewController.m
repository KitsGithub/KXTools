//
//  ViewController.m
//  KXTools
//
//  Created by kit on 16/4/22.
//  Copyright © 2016年 kit. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

//自定义类
#import "UIButton+iconWithTitle.h"
#import "KXCodingManager.h"
#import "KXKeyChainManager.h"
#import "KXCopyView.h"

//TouchID 管理类
#import "KXTouchIDManager.h"

@interface ViewController ()

@end

@implementation ViewController {
    LAContext *_context;
}

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
    
    
    
    //保存至 系统钥匙串中
    [KXKeyChainManager save:@"Account" data:@"381377046@qq.com"];
    [KXKeyChainManager save:@"Password" data:@"123123"];
    
    NSString *account = [KXKeyChainManager load:@"Account"];
    NSLog(@"%@",account);
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"account"] = @"381377046@qq.com";
    params[@"Passowrd"] = @"123123";
    [KXKeyChainManager save:@"AccountInfo" data:params];
    
    NSMutableDictionary *accountInfo = [KXKeyChainManager load:@"AccountInfo"];
    NSLog(@"%@",accountInfo);
    
    
    UIButton *touchID = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(button2.frame) + 30, [UIScreen mainScreen].bounds.size.width, 30)];
    [self.view addSubview:touchID];
    [touchID setTitle:@"点我调用touchID" forState:UIControlStateNormal];
    [touchID setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [touchID addTarget:self action:@selector(touchIDClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    

}

- (void)touchIDClick {
    if (!_context) {
        _context = [[LAContext alloc] init];
    }
    KXTouchIDManager *manager = [KXTouchIDManager shareManager];
    BOOL status = [manager canDeviverUseTouchIDWith:_context];
    if (status) {
        [manager callTouchIDWithlocalizedFallbackTitle:@"标题" andLocalizedFallbackMessage:@"副标题" success:^(BOOL success) {
            
            NSLog(@"验证成功");
            
        }];
    }
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
