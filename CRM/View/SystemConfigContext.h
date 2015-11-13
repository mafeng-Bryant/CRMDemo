//
//  SystemConfigContext.h
//  CRM
//
//  Created by 马峰 on 14-11-26.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemConfigContext : NSObject
{
    //当前用户信息
    NSMutableDictionary *userInfo;
}

+(SystemConfigContext *)sharedInstance;
-(NSString *)getString:(NSString *)key;
-(NSArray *)getResultItems:(NSString *)key;
-(NSArray*)getMenuConfigs;
-(NSArray*)getORGMenuItems;

//userId password userName
-(NSMutableDictionary *)getUserInfo;
-(void)setUser:(NSMutableDictionary *)userinfo;

-(NSString*)getSeviceHeader;

-(NSString*)getAppVersion;

-(NSString*)getDeviceID;

-(void)readSettings;

-(NSString *)getUserBMMC;
-(NSArray*)getTestMenuConfigs;

@end
