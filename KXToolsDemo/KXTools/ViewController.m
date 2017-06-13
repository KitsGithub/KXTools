//
//  ViewController.m
//  KXTools
//
//  Created by kit on 16/4/22.
//  Copyright © 2016年 kit. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

//自定义控制器
#import "Test1ViewController.h"
#import "Test2ViewController.h"

//自定义类
#import "KXCodingManager.h"
#import "KXKeyChainManager.h"

//TouchID 管理类
#import "KXTouchIDManager.h"

//FMDB的第三方封装

@interface ViewController ()

@end

@implementation ViewController {
    LAContext *_context;
    UILabel *_copyTestLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self setupNav];
    
    _copyTestLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 30)];
    _copyTestLabel.text = @"长按复制功能";
    _copyTestLabel.textAlignment = NSTextAlignmentCenter;
    _copyTestLabel.userInteractionEnabled = YES;
    [self.view addSubview:_copyTestLabel];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(copyLabelDidLongPress:)];
    [_copyTestLabel addGestureRecognizer:longPress];
    
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(_copyTestLabel.frame), 120, 44)];
    NSString *price = @"20";
    NSString *unit = @"块";
    NSString *targetStr = [price stringByAppendingString:unit];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:targetStr];
    [attStr setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} range:[targetStr rangeOfString:price]];
    [attStr setAttributes:@{NSForegroundColorAttributeName : [UIColor greenColor] , NSFontAttributeName : [UIFont systemFontOfSize:13]} range:[targetStr rangeOfString:unit]];
    label.attributedText = attStr;
    [self.view addSubview:label];
    
    
    
    //3DTouch 功能
    UIButton *touchID = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame) + 30, ScreenWidth, 30)];
    [self.view addSubview:touchID];
    [touchID setTitle:@"点我调用touchID" forState:UIControlStateNormal];
    [touchID setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [touchID addTarget:self action:@selector(touchIDClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    //加解密  功能
    UIButton *securityCoding = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(touchID.frame) + 30, ScreenWidth, 30)];
    [self.view addSubview:securityCoding];
    [securityCoding setTitle:@"点我调用加解密" forState:UIControlStateNormal];
    [securityCoding setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [securityCoding addTarget:self action:@selector(coding) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNav];
}



- (void)setupNav {
    self.title = @"测试";
    
    //设置导航栏背景
    self.navigationController.navigationBar.barTintColor = [UIColor purpleColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"跳转" style:UIBarButtonItemStylePlain target:self action:@selector(jumpToNavVc)];
    
    
}

//跳转到一个有导航栏的界面
- (void)jumpToNavVc {
    Test1ViewController *VC = [[Test1ViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

//加解密调用
- (void)coding {
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

}

//长按复制
-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(menuCopyBtnPressed:)) {
        return YES;
    }
    return NO;
}

- (void)copyLabelDidLongPress:(UILongPressGestureRecognizer *)gesture {
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(menuCopyBtnPressed:)];
        menuController.menuItems = @[copyItem];
        [menuController setTargetRect:gesture.view.frame inView:gesture.view.superview];
        [menuController setMenuVisible:YES animated:YES];
        [UIMenuController sharedMenuController].menuItems=nil;
    }
}

-(void)menuCopyBtnPressed:(UIMenuItem *)menuItem
{
    [UIPasteboard generalPasteboard].string = _copyTestLabel.text;
}

//touchID 调用
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
