//
//  MenuIcon.h
//  CRM
//
//  Created by 马峰 on 14-12-2.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuIcon : NSObject
@property(nonatomic,strong) NSString* iconString;
@property(nonatomic,strong) NSString* iconId;
@property(nonatomic,strong) NSString* title;
@property(nonatomic,strong) NSString* jumpPageString;
@property(nonatomic,strong) NSMutableArray* childArray;
@property(nonatomic,assign) int noticeCount;
@property(nonatomic,strong) NSMutableArray* argsArray;




@end
