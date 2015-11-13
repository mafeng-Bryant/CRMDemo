//
//  AppDelegate.h
//  CRM
//
//  Created by 马峰 on 14-11-26.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "Reachability.h"

typedef void(^roomCreateSuccessBlock)(BOOL isReachable);


@interface AppDelegate : UIResponder <UIApplicationDelegate,LoginViewDelegate>
{
    
}

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate*)getInstance;
- (void)showLoginView;

/**
 *  判断当前网络是否连接
 */
@property (nonatomic, assign) BOOL isConnectEnabled;
@property (strong,nonatomic)Reachability *reachiability;

@property (assign,nonatomic)BOOL isReachable;//是否可用

@property (assign,nonatomic)NetworkStatus status;//判定状态用的

- (void)getNetWorkStaus:(roomCreateSuccessBlock)block;


@end
