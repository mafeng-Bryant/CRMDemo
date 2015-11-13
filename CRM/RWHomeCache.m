//
//  RWHomeCache.m
//  RW
//
//  Created by 方鸿灏 on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RWHomeCache.h"

@implementation RWHomeCache

+ (NSString *) hashName: (NSString *)typeName;
{
	return [NSString stringWithFormat:@"%ld", [typeName hash]];
}

+ (NSMutableArray *) readFromFile: (NSString *)typeName
{
	NSError *error;
	//NSFileManager *file_manager = [NSFileManager defaultManager];
	//NSString *fileName = @"homeCache";
	NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	path = [path stringByAppendingPathComponent:typeName];
    NSMutableArray *arr = [[NSMutableArray alloc] initWithContentsOfFile:path];
    return arr;
//	if ([file_manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error])
//	{
//		//NSString *filename = [RWHomeCache hashName:typeName];
//       // NSString *data_file = [NSString stringWithFormat:@"%@/%@",path,filename];
//
//		NSMutableArray *arr = [[NSMutableArray alloc] initWithContentsOfFile:path];
//		return arr;
//	}
	
}

+ (NSInteger ) writeToFile: (NSMutableArray *)arr withName:(NSString *)typeName;
{
	NSString *fileName = @"homeCache";
	NSString *filename = [RWHomeCache hashName:typeName];
	NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	path = [path stringByAppendingPathComponent:typeName];
  //  NSString *data_file = [NSString stringWithFormat:@"%@/%@",path,filename];
    
    
   BOOL success = [arr writeToFile:path atomically:YES];
    NSLog(@"%d",success);
	return 0;
}
+ (NSString*)getpath:(NSString*)typeName
{
   // NSString *fileName = @"homeCache";
 //   NSString *filename = [RWHomeCache hashName:typeName];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    path = [path stringByAppendingPathComponent:typeName];
    return path;
  //  NSString *data_file = [NSString stringWithFormat:@"%@/%@",path,filename];
    
   // return data_file;
    
}

@end
