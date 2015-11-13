//
//  MySQLite.h
//  XMPPDemo
//
//  Created by 马峰 on 14-12-25.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
@class DetailProduct;

@interface MySQLite : NSObject
{
    BOOL isOpenDB;
}
@property(nonatomic,strong) FMDatabaseQueue* baseQueue;
+ (MySQLite*)shareSQLiteInstance;

//打开数据库
- (BOOL)OPenDBase;
//关闭数据库
- (void)closeDBase;
//插入数据
- (void)insertDataToSqlite:(NSString*)tableName message:(DetailProduct*)product;
//删除数据
- (void)clearDataToSqlite:(NSString*)tableName message:(DetailProduct*)product;
//检查数据表是否有数据，有数据为YES
- (BOOL)checkRecords:(NSString *)tableName;
- (void)clearDataByTableName:(NSString*)tableName;

//清除数据
- (void)clearAllData;
//清除离线数据库消息
- (BOOL)clearOutlineData:(NSString*)tablename;

//获取离线消息
- (NSArray*)getOutlineChatMessage:(NSString*)tableName;

- (void)changeDataBaseColoumn:(DetailProduct*)detailProduct tablename:(NSString*)tablename;
- (void)deleteProductFromDBase:(DetailProduct*)product;
- (NSArray*)getDetailProduct:(NSString*)tablename;





@end
