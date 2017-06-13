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
#import "KXActionSheet.h"
#import "KXAlertView.h"

//TouchID 管理类
#import "KXTouchIDManager.h"

//FMDB的第三方封装

@interface ViewController () <UITableViewDelegate,UITableViewDataSource,KXActionSheetDelegate,KXAlertViewDelegate>

@end

@implementation ViewController {
    LAContext *_context;
    UILabel *_copyTestLabel;
    UITableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self setupNav];
    
    [self setupView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self setupNav];
    [super viewWillAppear:animated];
}

#pragma mark - 功能

//base64加解密
- (void)Base64Coding {
    KXCodingManager *manager = [[KXCodingManager alloc] initWithSequreKey:@"yihezhai16816888"];
    
    NSString *encodingStr = [manager base64Encoding:@"我爱你"];
    NSLog(@"base64编码后的内容: %@",encodingStr);
    
    NSString *decodingStr = [manager base64Decoding:encodingStr];
    NSLog(@"base64解码后的内容: %@",decodingStr);
}

//AES加解密
- (void)AESCoding {
    KXCodingManager *manager = [[KXCodingManager alloc] initWithSequreKey:@"yihezhai16816888"];
    
    NSString *AESEncodingStr = [manager AESEncoding:@"我爱你"];
    NSLog(@"AES加密之后的内容: %@",AESEncodingStr);
    
    
    NSString *AESDecodingStr = [manager AESDecoding:AESEncodingStr];
    NSLog(@"AES解密之后的内容: %@",AESDecodingStr);
}

//保存至 系统钥匙串中
- (void)SaveToKeyChain {
    
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

//actionSheet
- (void)showActioSheet {
    KXActionSheet *sheet = [[KXActionSheet alloc] initWithTitle:@"标题" delegate:self cancellTitle:@"取消" andOtherButtonTitles:@[@"其他1",@"其他2",@"其他3"]];
    [sheet setImportanceTitleAtIndex:1];
    [sheet setSubTitleImageWithIndex:2 image:[UIImage imageNamed:@"textIcon_00"] titleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 12) WithAligment:UIControlContentHorizontalAlignmentCenter];
    
    NSString *price = @"20";
    NSString *unit = @"块";
    NSString *targetStr = [price stringByAppendingString:unit];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:targetStr];
    [attStr setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} range:[targetStr rangeOfString:price]];
    [attStr setAttributes:@{NSForegroundColorAttributeName : [UIColor greenColor] , NSFontAttributeName : [UIFont systemFontOfSize:13]} range:[targetStr rangeOfString:unit]];
    [sheet setTitleColorWithAttributedStr:attStr];
    [sheet show];
}


- (void)KXActionSheet:(KXActionSheet *)sheet andIndex:(NSInteger)index {
    NSLog(@"%zd",index);
}

- (void)KXActionSheetDidDisappear:(KXActionSheet *)sheet {
    NSLog(@"消失了");
}

// 自定义alertView
- (void)showAlertView {
    KXAlertView *alertView = [[KXAlertView alloc] initWithTitle:@"标题" andMessage:@"我是副标题我是副标题我是副标题我是副标题我是副标题_特殊文本" delegate:self andCancelButton:@"取消" andSubTitle:@"确定"];
    [alertView setSpacialLinkWithTargetStr:@"特殊文本"];
    [alertView show];
}

- (void)KXAlertView:(KXAlertView *)alertView ClickIndex:(NSUInteger)index {
    NSLog(@"%zd",index);
}

- (void)KXAlertView:(KXAlertView *)alertView ClickSpacialLinkWithLinkValue:(NSString *)linkValue {
    NSLog(@"%@",linkValue);
}

#pragma mark - UI布局
- (void)setupNav {
    self.title = @"测试";
    
    //设置导航栏背景
    self.navigationController.navigationBar.barTintColor = [UIColor purpleColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"跳转" style:UIBarButtonItemStylePlain target:self action:@selector(jumpToNavVc)];
}

- (void)setupView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"demoId"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"demoId" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"长按复制功能";
        _copyTestLabel = cell.textLabel;
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(copyLabelDidLongPress:)];
        [cell addGestureRecognizer:longPress];
    } else if (indexPath.row == 1) {
        
        NSString *price = @"20";
        NSString *unit = @"块";
        NSString *targetStr = [price stringByAppendingString:unit];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:targetStr];
        [attStr setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} range:[targetStr rangeOfString:price]];
        [attStr setAttributes:@{NSForegroundColorAttributeName : [UIColor greenColor] , NSFontAttributeName : [UIFont systemFontOfSize:13]} range:[targetStr rangeOfString:unit]];
        cell.textLabel.attributedText = attStr;
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"base64加解密";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"AES加解密";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"keyChain二次封装";
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"调用TouchID";
    } else if (indexPath.row == 6) {
        cell.textLabel.text = @"调用actionSheet";
    } else if (indexPath.row == 7) {
        cell.textLabel.text = @"调用alertView";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
    } else if (indexPath.row == 1) {
        
    } else if (indexPath.row == 2) {
        [self Base64Coding];
    } else if (indexPath.row == 3) {
        [self AESCoding];
    } else if (indexPath.row == 4) {
        [self SaveToKeyChain];
    } else if (indexPath.row == 5) {
        [self touchIDClick];
    } else if (indexPath.row == 6) {
        [self showActioSheet];
    } else if (indexPath.row == 7) {
        [self showAlertView];
    }
}

//跳转到一个有导航栏的界面
- (void)jumpToNavVc {
    Test1ViewController *VC = [[Test1ViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
