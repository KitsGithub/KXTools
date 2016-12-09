//
//  KXTouchIDManager.h
//  KXTools
//
//  Created by mac on 16/12/9.
//  Copyright © 2016年 kit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LAContext;

typedef enum : NSUInteger {
    TouchIDStatus1 = 0,
    TouchIDStatus2,
    TouchIDStatus3,
} TouchIDStatus;




@interface KXTouchIDManager : NSObject

+ (instancetype)shareManager;


/**
 判断设备的touchID状态
 
 @param locontext 上下文
 */
- (BOOL)canDeviverUseTouchIDWith:(LAContext *)context;


/**
 验证touchID

 @param localizedFallbackTitle 标题
 @param localizedFallbackMessage 副标题
 @param touchBlock 回调
 */
- (void)callTouchIDWithlocalizedFallbackTitle:(NSString *)localizedFallbackTitle andLocalizedFallbackMessage:(NSString *)localizedFallbackMessage success:(void(^)(BOOL success,NSError *error))touchBlock;

@end
