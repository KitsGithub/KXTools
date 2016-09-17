//
//  NSString+urlCoding.h
//  ZDShops
//
//  Created by zh on 16/4/8.
//  Copyright © 2016年 kit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (urlCoding)
/**
 *  中文编码
 *
 *  @param str 编码内容
 *
 *  @return 编码之后的内容
 */
+ (instancetype)URLEncodedString:(NSString *)str;

/**
 *  中文解码
 *
 *  @param str 解码内容
 *
 *  @return 解码之后的内容
 */
+ (instancetype)URLDecodedString:(NSString *)str;
@end
