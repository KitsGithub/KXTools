//
//  FMDBManager.m
//  FMDBTestDemo
//
//  Created by mac on 16/9/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "FMDBManager.h"
#import "SDTimeLineCellModel.h"
#import <objc/runtime.h>


#define Sqlite 的路径
#define ZhiMaSqlitePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"ZhiMa.sqlite"]

#define ZhiMaCicle_Talbe_Name @"Circle "
#define ZhiMaCicleComment_Table_Name @"Circle_Comment "

//  创建朋友圈table字段
#define CircleField @"(id INTEGER PRIMARY KEY AUTOINCREMENT, friend_nick TEXT NOT NULL, fcid TEXT NOT NULL, openfireaccount TEXT NOT NULL, content TEXT NOT NULL, current_location TEXT NOT NULL, create_time TEXT NOT NULL, head_photo TEXT NOT NULL)"

// 取朋友圈table的字段名
#define CircleFiels_Name @"friend_nick, fcid, openfireaccount, content, current_location, create_time, head_photo"

// 创建评论table字段
#define Circle_CommentField @"(id INTEGER PRIMARY KEY AUTOINCREMENT, friend_nick TEXT NOT NULL, fcid TEXT NOT NULL, openfireaccount TEXT NOT NULL, comment TEXT NOT NULL, reply_friend_nick TEXT NOT NULL, reply_openfireaccount TEXT NOT NULL, head_photo TEXT NOT NULL, create_time TEXT NOT NULL)"

// 取评论字段名
#define Circle_CommentFields_Name @"friend_nick, openfireaccount, comment, reply_friend_nick, reply_openfireaccount, fcid, head_photo, create_time"



@implementation FMDBManager {
    FMDatabase *circle_DB;
    FMDatabase *circle_Comment_DB;
}

+ (instancetype)shareManager {
    return [[self alloc] initWithShareManager];
}

- (instancetype)initWithShareManager {
    static FMDBManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FMDBManager alloc] init];
    });
    return manager;
}


#pragma mark - 建表
- (BOOL)creatTableWithTableType:(ZhiMaSqliteTableType)type {
    NSLog(@"表的路径 %@",ZhiMaSqlitePath);
    // 1.通过路径创建数据库
    FMDatabase *db = [FMDatabase databaseWithPath:ZhiMaSqlitePath];
    
    if ([db open]) {
        NSLog(@"打开成功");
        NSString *tableField = [NSString string];
        NSString *tableName = [NSString string];
        switch (type) {
            case ZhiMa_Circle_Table: {         //如果创建的是朋友圈表
                tableField = CircleField;
                tableName = ZhiMaCicle_Talbe_Name;
                circle_DB = db;
                break;
            }
            case ZhiMa_Circle_Comment_Table: {  //如果创建的是评论表
                tableField = Circle_CommentField;
                tableName = ZhiMaCicleComment_Table_Name;
                circle_Comment_DB = db;
                break;
            }
            default:{
                NSLog(@"无效参数");
                return NO;
                break;
            }
        }
        
        NSString *operationString = [@"CREATE TABLE IF NOT EXISTS " stringByAppendingString:tableName];
        operationString = [operationString stringByAppendingString:tableField];
        BOOL success = [db executeUpdate:operationString];
        
        if (success) {
            return YES;
        } else {
            return NO;
        }
        
    } else {
        NSLog(@"打开失败");
        return NO;
    }
}

#pragma mark - 插表
- (BOOL)InsertDataInTable:(ZhiMaSqliteTableType)type withModel:(id)model {
    
    FMDatabase *db;
    NSString *tableName = [NSString string];  //表名
    NSString *fieldName;                      //字段名
    switch (type) {
        case ZhiMa_Circle_Table: {
            db = circle_DB;
            tableName = ZhiMaCicle_Talbe_Name;
            fieldName = CircleFiels_Name;
            break;
        }
        case ZhiMa_Circle_Comment_Table: {
            db = circle_Comment_DB;
            tableName = ZhiMaCicleComment_Table_Name;
            fieldName = Circle_CommentFields_Name;
            break;
        }
        default: {
            NSLog(@"无效参数");
            return NO;
            break;
        }
    }
    
    NSString *operationString = [@"INSERT INTO " stringByAppendingString:tableName];
    NSString *valuesStr = [self getValuesString:fieldName];
    operationString = [operationString stringByAppendingString:[NSString stringWithFormat:@"(%@) VALUES %@",fieldName,valuesStr]];
    
    // 动态获取模型的属性名
    NSArray *pArray = [self getPropertyNameArrayWith:model];
    pArray = [self getProperyWith:model andArray:[pArray mutableCopy]];
    if (pArray.count == 0) {
        return NO;
    }
    BOOL success = [db executeUpdate:operationString, pArray[0], pArray[1], pArray[2], pArray[3], pArray[4], pArray[5], pArray[6]];
    
    if (success) {
        return YES;
    } else {
        return NO;
    }
    
}


#pragma mark - 查表
/**
 *  查表
 *
 *  @param type   要查的那张表
 *  @param option  要执行的操作 WHERE id > 0  查询id > 0 的数据
 *  @param target  数据类型
 *
 *  @return 查出表的数据的数组
 */
- (NSArray *)CheckTable:(ZhiMaSqliteTableType)type withOption:(NSString *)option andTargetClass:(Class)modelClass {
    NSMutableArray *dataArray = [NSMutableArray array];
    
    FMDatabase *db;
    NSString *tableName = [NSString string];  //表名
    NSString *fieldName;                      //字段名
    switch (type) {
        case ZhiMa_Circle_Table: {
            db = circle_DB;
            tableName = ZhiMaCicle_Talbe_Name;
            fieldName = CircleFiels_Name;
            break;
        }
        case ZhiMa_Circle_Comment_Table: {
            db = circle_Comment_DB;
            tableName = ZhiMaCicleComment_Table_Name;
            fieldName = Circle_CommentFields_Name;
            break;
        }
        default: {
            NSLog(@"无效参数");
            return nil;
            break;
        }
    }
    
    NSString *operationString = @"SELECT ";
    operationString = [operationString stringByAppendingString:fieldName];
    operationString = [operationString stringByAppendingString:[NSString stringWithFormat:@" FROM %@ %@;",tableName,option]];
    FMResultSet *result = [circle_DB executeQuery:operationString];
    
    
    while ([result next]) {
        
        id model = [self setPropertyWithResule:result WithClass:modelClass];

        [dataArray addObject:model];
    }
    
    
    return dataArray;
}


// 拼接参数
- (NSString *)getValuesString:(NSString *)fieldStr {
    
    NSArray *array = [fieldStr componentsSeparatedByString:@","];
    NSString *valueString = @"(";
    for (NSInteger index = 0; index < array.count; index++) {
        
        if (index == 0) {
            valueString = [valueString stringByAppendingString:@"?"];
        } else {
            valueString = [valueString stringByAppendingString:@", ?"];
        }
        
    }
    
    valueString = [valueString stringByAppendingString:@");"];
    
    return valueString;
}


#pragma mark - 动态取出模型的所有属性
- (NSArray *)getPropertyNameArrayWith:(id)model {
    // 动态获取模型的属性名
    NSMutableArray *pArray = [NSMutableArray array];
    unsigned int count = 0;
    
    objc_property_t *properties = class_copyPropertyList([model class], &count);
    
    for (int index = 0; index < count; ++index) {
        // 根据索引获得对应的属性(属性是一个结构体,包含很多其他的信息)
        objc_property_t property = properties[index];
        // 获得属性名字
        const char *cname = property_getName(property);
        // 将c语言字符串转换为oc字符串
        NSString *ocname = [[NSString alloc] initWithCString:cname encoding:NSUTF8StringEncoding];
        
        [pArray addObject:ocname];
    }
    return pArray;
}

// 获取模型属性的值
- (NSArray *)getProperyWith:(id)model andArray:(NSMutableArray *)pArray {
    for (NSInteger index = 0; index < pArray.count; index++) {
        NSMutableString *resultString = [[NSMutableString alloc] init];
        //获取get方法
        SEL getSel = [self creatGetterWithPropertyName:pArray[index]];
        //获得类和方法的签名
        NSMethodSignature *signature = [model methodSignatureForSelector:getSel];
        
        //从签名获得调用对象
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        
        //设置target
        [invocation setTarget:model];
        
        //设置selector
        [invocation setSelector:getSel];
        
        //接收返回的值
        NSObject *__unsafe_unretained returnValue = nil;
        
        //调用
        [invocation invoke];
        
        //接收返回值
        [invocation getReturnValue:&returnValue];
        
        [resultString appendFormat:@"%@", returnValue];
        [pArray replaceObjectAtIndex:index withObject:resultString];
        
    }
    return pArray;

}

// 设置模型属性的值
- (id)setPropertyWithResule:(FMResultSet *)result WithClass:(Class)modelClass {
    
    //实例化一个model
    id model = [[modelClass alloc] init];
    
    NSArray *pArray = [self getPropertyNameArrayWith:model];

    for (NSInteger index = 0; index < pArray.count; index++ ) {
        //获取set方法
        SEL setSel = [self creatSetterWithPropertyName:pArray[index]];
        
        if ([model respondsToSelector:setSel]) {
            NSString *value = [result stringForColumn:pArray[index]];
            value = [value stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[value substringToIndex:1] uppercaseString]];
            [model performSelectorOnMainThread:setSel withObject:value waitUntilDone:[NSThread isMainThread]];
            
        }
        
    }
    return model;
    
}

#pragma mark -- 通过字符串来创建该字符串的Setter方法，并返回
// 获取属性的Get方法
- (SEL)creatGetterWithPropertyName: (NSString *) propertyName{
    //1.返回get方法: oc中的get方法就是属性的本身
    return NSSelectorFromString(propertyName);
}
// 获取属性的set 方法
- (SEL)creatSetterWithPropertyName:(NSString *)propertyName {
    NSString *selName = [NSString stringWithFormat:@"set%@:",propertyName];
    return NSSelectorFromString(selName);
}





@end
