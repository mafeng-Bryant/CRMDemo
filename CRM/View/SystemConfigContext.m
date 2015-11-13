//
//  SystemConfigContext.m
//  CRM
//
//  Created by 马峰 on 14-11-26.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import "SystemConfigContext.h"

static NSMutableDictionary *config;
static SystemConfigContext *_sharedSingleton = nil;

@implementation SystemConfigContext

+ (SystemConfigContext *) sharedInstance
{
    @synchronized(self)
    {
        if(_sharedSingleton == nil)
        {
            _sharedSingleton = [[SystemConfigContext alloc] init];
            
            NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"plist"];
            config = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
            
            
        }
    }
    
    return _sharedSingleton;
}
-(NSString *)getString:(NSString *)key{
    return [config objectForKey:key];
}

-(NSArray *)getResultItems:(NSString *)key{
    return [config objectForKey:key];
}

-(NSMutableDictionary *)getUserInfo{
    return userInfo;
}

-(void)setUser:(NSMutableDictionary *)userinfo{
    userInfo = userinfo;
}
-(NSString*)getAppVersion{
    return [NSString stringWithFormat:@"%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
}
-(NSArray*)getTestMenuConfigs{
    return [config objectForKey:@"data"];
}
-(NSArray*)getMenuConfigs{
    return [config objectForKey:@"MenuItems"];
}


@end
