//
//  MySQLite.m
//  XMPPDemo
//
//  Created by 马峰 on 14-12-25.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import "MySQLite.h"
#import "DetailProduct.h"


static MySQLite* sqliteInstance= nil;

static bool checkTablesFlag = NO;


@interface MySQLite()
@property(nonatomic,strong) NSMutableArray* tableNamesArray;

@end

@implementation MySQLite
+ (MySQLite*)shareSQLiteInstance
{
    static dispatch_once_t lock;
    dispatch_once(&lock,^{
        
        sqliteInstance = [[MySQLite alloc]init];
    });
    
    return sqliteInstance;
 
}
//打开数据库
- (BOOL)OPenDBase
{
    if (isOpenDB) {
        
        return YES;
    }
 
    NSArray *documentsPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory
                                                                , NSUserDomainMask
                                                                , YES);
    NSString *databaseFilePath=[[documentsPaths objectAtIndex:0] stringByAppendingPathComponent:@"M.db"];
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:databaseFilePath]) {
        
        [fileManager removeItemAtPath:databaseFilePath error:nil];
        [fileManager createFileAtPath:databaseFilePath contents:nil attributes:nil];
        
    }
    
    
//    [[NSUserDefaults standardUserDefaults]setObject:databaseFilePath forKey:@"mj"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    self.baseQueue = [[FMDatabaseQueue alloc]initWithPath:databaseFilePath];
    if (!self.baseQueue) {
        return NO;
    }
    isOpenDB = YES;
    //数据库表创建检测
    [self checkSystemTables];
    return YES;
}

- (void)checkSystemTables
{
    if (checkTablesFlag) {
        return;
    }
    __block BOOL success = NO;
    
    NSMutableArray* tableNamesArray = [NSMutableArray array];
    [tableNamesArray addObject:@"ProductTable"];
    
    for (NSString* tableName in tableNamesArray) {
        //为每一个好友列表创建一个数据库，同时创建一个离线数据库，用于提醒未读消息，每次看完离线消息后就清除离线数据库的数据，确保内存空间。
      NSString* sql = [NSString stringWithFormat:@"CREATE TABLE if not exists %@(detailProductId VARCHAR(50),clickOut VARCHAR(50),fCreateTime VARCHAR(50),detailProductTitle VARCHAR(50),priceNumber VARCHAR(50),fUnit VARCHAR(50),FStoreAvatarImageId VARCHAR(300),FMasterCatalogId VARCHAR(50))",tableName];
        

        [self.baseQueue inDatabase:^(FMDatabase *db) {
            success = [db executeUpdate:sql];
        }];
        if (success == NO ){
            NSLog(@"error###exec sql:%@",sql);
        }
        success = NO;
    }
 
  checkTablesFlag = YES;
    
}
//关闭数据库
- (void)closeDBase
{
    if(isOpenDB) [self.baseQueue close];
    isOpenDB = NO;
}
//插入数据
- (void)insertDataToSqlite:(NSString*)tableName message:(DetailProduct*)product
{
    //每次操作数据库必须先打开。
    if (isOpenDB ==NO) {
        [self OPenDBase];
    }
    if (product ==nil) {
        return;
    }
    FMDatabase* db = [self.baseQueue database];
    if(db ==nil) return ;
    [db beginTransaction];
    NSString* clickOut =[[NSNumber numberWithInt:product.clickCount] stringValue];
    NSString* fCreateTime = product.fCreateTime;
    NSString* detailProductId = product.detailProductId;
    NSString* detailProductTitle =product.detailProductTitle;
    NSString* priceNumber = [product.priceNumber stringValue];
    NSString* fUnit =product.fUnit;
    NSString* FStoreAvatarImageId = product.FStoreAvatarImageId;
    NSString* FMasterCatalogId = product.FMasterCatalogId;
    NSMutableString* sqlstr =[NSMutableString string];
    [sqlstr appendFormat:@"insert into %@(detailProductId,clickOut,fCreateTime,detailProductTitle,priceNumber,fUnit,FStoreAvatarImageId,FMasterCatalogId) values('%@','%@','%@','%@','%@','%@','%@','%@')",tableName,detailProductId,clickOut,fCreateTime,detailProductTitle,priceNumber,fUnit,FStoreAvatarImageId,FMasterCatalogId];
   // FMasterCatalogId VARCHAR(50)
    BOOL result = [db executeUpdate:sqlstr];
    NSLog(@"result = %d",result);
    [db commit];
}
- (void)changeDataBaseColoumn:(DetailProduct*)detailProduct tablename:(NSString*)tablename
{
    //每次操作数据库必须先打开。
    if (isOpenDB ==NO) {
        [self OPenDBase];
    }
    if (detailProduct ==nil) {
        return;
    }
    __block BOOL success = NO;
    NSString* clickOut =[[NSNumber numberWithInt:detailProduct.clickCount] stringValue];
    NSString* fCreateTime = detailProduct.fCreateTime;
    NSString* detailProductId = detailProduct.detailProductId;
    NSString* detailProductTitle =detailProduct.detailProductTitle;
    NSString* priceNumber = [detailProduct.priceNumber stringValue];
    NSString* fUnit =detailProduct.fUnit;
    NSString* FStoreAvatarImageId = detailProduct.FStoreAvatarImageId;
    NSString* FMasterCatalogId = detailProduct.FMasterCatalogId;

    
    NSString *sql1 = [NSString stringWithFormat:@"delete from ProductTable where detailProductId = '%@'",detailProduct.detailProductId];
    
    NSMutableString* sqlstr =[NSMutableString string];
    [sqlstr appendFormat:@"insert into %@(detailProductId,clickOut,fCreateTime,detailProductTitle,priceNumber,fUnit,FStoreAvatarImageId,FMasterCatalogId) values('%@','%@','%@','%@','%@','%@','%@','%@')",tablename,detailProductId,clickOut,fCreateTime,detailProductTitle,priceNumber,fUnit,FStoreAvatarImageId,FMasterCatalogId];
    
      [self.baseQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:sql1];
        success = [db executeUpdate:sqlstr];
        
    }];
    
    if (success == NO){
        NSLog(@"error###exec sql:%@",sqlstr);
    }
}
- (NSArray*)getOutlineChatMessage:(NSString*)tableName
{
    if (!isOpenDB) {
        
        [self OPenDBase];
    }

    NSMutableArray *__block ary = [[NSMutableArray alloc] initWithCapacity:40];
    NSString *sql = [NSString stringWithFormat:@"select * from %@",tableName];
    [self.baseQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql];
        
        while ([rs next]) {
            
            [ary addObject:[rs getAwayMessage]];
        }
        [rs close];
    }];
    
    return ary;
}
- (NSArray*)getDetailProduct:(NSString*)tablename
{

    if (!isOpenDB) {
        
        [self OPenDBase];
    }
    
    NSMutableArray *__block ary = [[NSMutableArray alloc] initWithCapacity:40];
    NSString *sql = [NSString stringWithFormat:@"select * from %@",tablename];
    [self.baseQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql];
        
        while ([rs next]) {
            
            [ary addObject:[rs getMyProduct]];
        }
        [rs close];
    }];
    
    return ary;
    

}
- (void)deleteProductFromDBase:(DetailProduct*)product
{
    NSLog(@"%@",product);
    
    if (isOpenDB ==NO) {
    [self OPenDBase];
   }
    if (product ==nil) {
        return;
    }
    __block BOOL success = NO;
    
    NSString *sql = [NSString stringWithFormat:@"delete from ProductTable where detailProductId = '%@'",product.detailProductId];
    [self.baseQueue inDatabase:^(FMDatabase *db) {
        
        success = [db executeUpdate:sql];
    }];
    if (success == NO){
        NSLog(@"error###exec sql:%@",sql);
    }
    

}
- (void)clearDataByTableName:(NSString*)tableName
{
    if (isOpenDB ==NO) {
        [self OPenDBase];
     }
    
    __block BOOL success = NO;
    
    NSString *sql = [NSString stringWithFormat:@"delete from %@ ",tableName];
    
    [self.baseQueue inDatabase:^(FMDatabase *db) {
        
        success = [db executeUpdate:sql];
    }];
    if (success == NO){
        NSLog(@"error###exec sql:%@",sql);
    }

}
//清除离线数据库消息
- (BOOL)clearOutlineData:(NSString*)tablename
{
    if (!tablename) {
        
        return NO;
    }
    if (isOpenDB==NO) {
        
        [self OPenDBase];
    }
    __block BOOL success = NO;
    
    NSString *sql = [NSString stringWithFormat:@"delete from %@ ",tablename];
    
    [self.baseQueue inDatabase:^(FMDatabase *db) {
        
        success = [db executeUpdate:sql];
    }];
    if (success == NO){
        NSLog(@"error###exec sql:%@",sql);
    }
    return success;
    
}
//删除数据
- (void)deleteDataFromSqlite:(NSString*)tableName message:(NSString*)message
{

}
//检查数据表是否有数据，有数据为YES
- (BOOL)checkRecords:(NSString *)tableName
{

    return YES;
}
//清除数据
- (void)clearAllData
{

}
@end
