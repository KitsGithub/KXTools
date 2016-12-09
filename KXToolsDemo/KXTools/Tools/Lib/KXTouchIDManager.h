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


@protocol KXTouchIDManagerDelegate <NSObject>



@end


@interface KXTouchIDManager : NSObject

+ (instancetype)shareManager;

//错误回调代理
@property (nonatomic, weak) id <KXTouchIDManagerDelegate> delegate;

/**
 判断设备的touchID状态
 
 @param locontext 上下文
 */
- (BOOL)canDeviverUseTouchIDWith:(LAContext *)context;


/**
 验证touchID

 @param localizedFallbackTitle 标题
 @param localizedFallbackMessage 副标题
 @param touchBlock 成功回调
 */
- (void)callTouchIDWithlocalizedFallbackTitle:(NSString *)localizedFallbackTitle andLocalizedFallbackMessage:(NSString *)localizedFallbackMessage success:(void(^)(BOOL success))touchBlock;




@end
