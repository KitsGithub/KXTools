//
//  AESCodingManager.h
//  aesEncoding
//
//  Created by mac on 16/9/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KXCodingManager : NSObject

@property (nonatomic, copy,readonly) NSString *SequreKey;

+ (instancetype)shareInstance;
//创建1个单例对象
- (instancetype)initWithSequreKey:(NSString *)privateKey;

#pragma mark - base64编码/解码
#pragma mark base64编码
/**
 *  Base64编码
 *  enCodingContent  编码字符串
 *  return  内容经过Base64编码之后的字符串
 */
- (NSString *)base64Encoding:(NSString *)enCodingContent;

/**
 *  Base64编码
 *  encodingData  编码Data
 *  return  内容经过Base64编码之后的字符串
 */
- (NSString *)base64EncodingWithData:(NSData *)encodingData;

/**
 *  Base64编码
 *  enCodingContent  编码字符串
 *  return  内容经过Base64编码之后的NSData
 */
- (NSData *)base64EncodingWithString:(NSString *)enCodingContent;




#pragma mark base64解码
/**
 *  Base64解码
 *  deCodingContent  待解码字符串
 *  return  内容经过Base64解码之后的字符串
 */
- (NSString *)base64Decoding:(NSString *)deCodingContent;



#pragma mark - AES编码/解码
#pragma mark AES编码
/**
 *  AES编码 + base64编码
 *  一个字符串，经过 _privateKey 进行AES加密并进行Bser64加密
 *  _privateKey 私钥  通过initWithSequreKey创建
 *  enCodingContent  编码内容
 *  return  编码后的内容
 */
- (NSString *)AESEncoding:(NSString *)enCodingContent;


/**
 *  AES编码
 *  一个字符串，经过 _privateKey 进行AES加密
 *  _privateKey :私钥  通过instanceType创建
 *  enCodingContent  编码内容
 *  return  编码后的NSData
 */
- (NSData *)AESEncodingWithString:(NSString *)enCodingContent;


#pragma mark AES编码
/**
 *  AES解码 + base64解码
 *  一个经过AES编码过的字符串，通过 _privateKey 解码
 *  _privateKey :私钥  通过initWithSequreKey创建
 *  deCodingContent  解码内容
 *  return 解码后的字符串
 */
- (NSString *)AESDecoding:(NSString *)deCodingContent;


/**
 *  AES解码
 *  一个经过AES编码过的字符串，通过 _privateKey 解码
 *  _privateKey :私钥  通过instanceType创建
 *  deCodingContent  解码内容
 *  return 解码后的NSData
 */
- (NSData *)AESDecodingWithString:(NSString *)deCodingContent;


#pragma mark - zip的编码与解码
- (NSData *)decodeZipData:(NSData *)zipData;

@end
