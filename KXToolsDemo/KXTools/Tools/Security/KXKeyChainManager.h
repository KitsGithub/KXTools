//
//  KXKeyChainManager.h
//  TouchIDTest
//
//  Created by mac on 16/12/9.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KXKeyChainManager : NSObject

// save username and password to keychain
+ (void)save:(NSString *)service data:(id)data;

// take out username and passwore from keychain
+ (id)load:(NSString *)service;

// delete username and password from keychain
+ (void)delete:(NSString *)service;

@end
