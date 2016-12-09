//
//  KXTouchIDManager.m
//  KXTools
//
//  Created by mac on 16/12/9.
//  Copyright © 2016年 kit. All rights reserved.
//

#import "KXTouchIDManager.h"
//系统框架
#import <LocalAuthentication/LocalAuthentication.h>

@implementation KXTouchIDManager

+ (instancetype)shareManager {
    static KXTouchIDManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[KXTouchIDManager alloc] init];
    });
    return manager;
}


/**
 判断设备的touchID状态
 
 @param locontext 上下文
 */
- (BOOL)canDeviverUseTouchIDWith:(LAContext *)context {
    
    if (!context) {
        context = [[LAContext alloc] init];
    }
    
    NSError *error;
    [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error];
    
    return [self ErrorStatus:error];
}


/**
 验证touchID
 
 @param localizedFallbackTitle 标题
 @param localizedFallbackMessage 副标题
 @param touchBlock 回调
 */
- (void)callTouchIDWithlocalizedFallbackTitle:(NSString *)localizedFallbackTitle andLocalizedFallbackMessage:(NSString *)localizedFallbackMessage success:(void(^)(BOOL success))touchBlock {
    
    LAContext  *context= [[LAContext alloc] init];
    context.localizedFallbackTitle= localizedFallbackTitle;
    
    if ([self canDeviverUseTouchIDWith:context]) {
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:localizedFallbackMessage reply:^(BOOL success, NSError * _Nullable error) {
            
            if ([self ErrorStatus:error]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    touchBlock(success);
                });
            }
            
        }];
    }
}


/**
 私有方法 - 验证错误状态

 @param error error对象
 @return YES 验证成功  NO 验证失败
 */
- (BOOL)ErrorStatus:(NSError *)error {
    if (error.code == LAErrorTouchIDLockout) { //touchID被锁
        return NO;
    } else if (error.code == LAErrorTouchIDNotAvailable) { //touchID 不可用
        return NO;
    } else if (error.code == LAErrorPasscodeNotSet) { //touchID 未设置
        return NO;
    }
    return YES;
}

@end
