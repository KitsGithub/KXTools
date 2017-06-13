//
//  AESCodingManager.m
//  aesEncoding
//
//  Created by mac on 16/9/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "KXCodingManager.h"
#import "GTMBase64.h"
#import "NSData+AES.h"
#import "NSString+MD5.h"

#import <zlib.h>

static KXCodingManager *manager = nil;
static dispatch_once_t onceToken;

@interface KXCodingManager ()

@end


@implementation KXCodingManager

+ (instancetype)shareInstanceWithSequreKey:(NSString *)sequreKey {
    return [[self alloc] initWithSequreKey:sequreKey];
}

//创建1个单例对象
- (instancetype)initWithSequreKey:(NSString *)privateKey {
    
    //创建单例对象
    dispatch_once(&onceToken, ^{
        manager = [[KXCodingManager alloc] init];
    });
    
    manager.SequreKey = privateKey;
    
    return manager;
}


//set方法
- (void)setSequreKey:(NSString *)SequreKey {
    _SequreKey = SequreKey;
}

#pragma mark - base64编码
/**
 *  Base64编码
 *  enCodingContent  编码字符串
 *  return  内容经过Base64编码之后的字符串
 */
- (NSString *)base64Encoding:(NSString *)enCodingContent {
    
    NSString *base64EncodingStr = [[NSString alloc] initWithData:[self base64EncodingWithString:enCodingContent] encoding:NSUTF8StringEncoding];
    
    return base64EncodingStr;
}


/**
 *  Base64编码
 *  encodingData  编码Data
 *  return  内容经过Base64编码之后的字符串
 */
- (NSString *)base64EncodingWithData:(NSData *)encodingData  {
    encodingData = [GTMBase64 encodeData:encodingData];
    return [[NSString alloc] initWithData:encodingData encoding:NSUTF8StringEncoding];
}


/**
 *  Base64编码
 *  enCodingContent  编码字符串
 *  return  内容经过Base64编码之后的NSData
 */
- (NSData *)base64EncodingWithString:(NSString *)enCodingContent {
    NSData *enCodingData = [enCodingContent dataUsingEncoding:NSUTF8StringEncoding];
    
    enCodingData = [GTMBase64 encodeData:enCodingData];
    
    return enCodingData;
}


#pragma mark - base64解码
/**
 *  Base64解码
 *  deCodingContent  待解码字符串
 *  return  内容经过Base64解码之后的字符串
 */
- (NSString *)base64Decoding:(NSString *)deCodingContent {
    
    NSString *base64DecodingStr = [[NSString alloc] initWithData:[self base64DecodingWithString:deCodingContent] encoding:NSUTF8StringEncoding];
    return base64DecodingStr;
}

- (NSData *)base64DecodingWithString:(NSString *)encodingString {
    
    NSData *data = [encodingString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 decodeData:data];
    return data;
}

- (NSString *)base64DecodingWithData:(NSData *)decodingData  {
    NSData *base64DecodeData = [[NSData alloc] initWithBase64EncodedData:decodingData options:0];
    NSString *decodeStr = [[NSString alloc] initWithData:base64DecodeData encoding:NSUTF8StringEncoding];
    return decodeStr;
}


/**
 *  AES编码 + base64编码
 *  一个字符串，经过 _privateKey 进行AES加密并进行Bser64加密
 *  _privateKey 私钥  通过initWithSequreKey创建
 *  enCodingContent  编码内容
 *  return  编码后的内容
 */
- (NSString *)AESEncoding:(NSString *)enCodingContent {
    //AES编码
    NSData *encodingData = [self AESEncodingWithString:enCodingContent];
    //base64加密
    NSString *AESEncodingStr = [self base64EncodingWithData:encodingData];
    
    return AESEncodingStr;
}

/**
 *  AES编码
 *  一个字符串，经过 _privateKey 进行AES加密
 *  _privateKey :私钥  通过instanceType创建
 *  enCodingContent  编码内容
 *  return  编码后的NSData
 */
- (NSData *)AESEncodingWithString:(NSString *)enCodingContent {
    NSData *enCodingData = [enCodingContent dataUsingEncoding:NSUTF8StringEncoding];
    
    enCodingData = [enCodingData AES256EncryptWithKey:self.SequreKey];
    return enCodingData;
}


#pragma mark - AES解码
/**
 *  AES解码 + base64解码
 *  一个经过AES编码过的字符串，通过 _privateKey 解码
 *  _privateKey :私钥  通过instanceType创建
 *  deCodingContent  解码内容
 *  return 解码后的字符串
 */
- (NSString *)AESDecoding:(NSString *)deCodingContent {
    
    NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:deCodingContent options:0];
    
    decodeData = [decodeData AES256DecryptWithKey:self.SequreKey];
    
    NSString *AESDEcodingStr = [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
    
    return AESDEcodingStr;
}

/**
 *  AES解码
 *  一个经过AES编码过的字符串，通过 _privateKey 解码
 *  _privateKey :私钥  通过instanceType创建
 *  deCodingContent  解码内容
 *  return 解码后的NSData
 */
- (NSData *)AESDecodingWithString:(NSString *)deCodingContent {
    
    NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:deCodingContent options:0];
    decodeData = [decodeData AES256DecryptWithKey:self.SequreKey];
    return decodeData;
}


#pragma mark - zip的编码与解码
- (NSData *)decodeZipData:(NSData *)zipData {
    if (zipData.length == 0) {
        return zipData;
    }
    
    unsigned full_length = (int)[zipData length];
    unsigned half_length = (int)[zipData length] / 2;
    
    NSMutableData *decompressed = [NSMutableData dataWithLength: full_length + half_length];
    BOOL done = NO;
    int status;
    
    z_stream strm;
    strm.next_in = (Bytef *)[zipData bytes];
    strm.avail_in = (int)[zipData length];
    strm.total_out = 0;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    
    if (inflateInit2(&strm, (15+32)) != Z_OK)
        return nil;
    
    while (!done)
    {
        // Make sure we have enough room and reset the lengths.
        if (strm.total_out >= [decompressed length])
            [decompressed increaseLengthBy: half_length];
        strm.next_out = [decompressed mutableBytes] + strm.total_out;
        strm.avail_out = (uint)[decompressed length] - (uint)strm.total_out;
        
        // Inflate another chunk.
        status = inflate (&strm, Z_SYNC_FLUSH);
        if (status == Z_STREAM_END)
            done = YES;
        else if (status != Z_OK)
            break;
    }
    if (inflateEnd (&strm) != Z_OK)
        return nil;
    
    // Set real length.
    if (done)
    {
        [decompressed setLength: strm.total_out];
        return [NSData dataWithData: decompressed];
    }
    else return nil;
}



@end
