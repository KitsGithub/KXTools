//
//  FMDBManager.h
//  FMDBTestDemo
//
//  Created by mac on 16/9/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SDTimeLineCellModel;

typedef enum : NSUInteger {
    ZhiMa_Circle_Table,   // 朋友圈的表
    ZhiMa_Circle_Comment_Table   //朋友圈评论的表
} ZhiMaSqliteTableType;

@interface FMDBManager : NSObject


+ (instancetype)shareManager;

// 建表
- (BOOL)creatTableWithTableType:(ZhiMaSqliteTableType)type;

// 插表
- (BOOL)InsertDataInTable:(ZhiMaSqliteTableType)type withModel:(id)model;

// 查表
- (NSArray *)CheckTable:(ZhiMaSqliteTableType)type withOption:(NSString *)option andTargetClass:(Class)modelClass;

// 改表

// 删表

@end
