//
//  NSString+MD5.h
//  YiIM_iOS
//
//  Created by mac on 16/8/26.
//  Copyright © 2016年 ikantech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)
+ (NSString *)md5:(NSString *)str;
+(NSString *)file_md5:(NSString*) path;

- (NSString *)md5Encrypt;
@end
