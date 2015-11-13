//
//  AppDelegate.m
//  CRM
//
//  Created by 马峰 on 14-11-26.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import "AppDelegate.h"
#import "MainMenuViewController.h"
//#import <CamCardOpenAPIFramework/OpenAPI.h>
#import "MySQLite.h"
#import "AFNetworking.h"


static AppDelegate *instance = nil;

@implementation AppDelegate
+ (AppDelegate*)getInstance
{
    return instance;
}
- (void)showLoginView
{
  
    LoginViewController *ctrl = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    ctrl.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:ctrl];
    nav.navigationBar.tintColor = dayiColor;
    nav.navigationBarHidden = YES;
    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
}
- (void)didLogin
{
   self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   MainMenuViewController* mainVC = [[MainMenuViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    if (IOS7)
        nav.navigationBar.barTintColor = [UIColor whiteColor];
    nav.navigationBarHidden = YES;
    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
     instance = self;
  // [self monitoringNetwork]; //进行网络状况监听
    
    NSLog(@"test");
    
    //开启网络状况的监听
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    self.reachiability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    [self.reachiability startNotifier];  //开始监听，会启动一个run loop
    // Reachability
   // [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    if (IOS7) { // 判断是否是IOS7
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
   [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [[MySQLite shareSQLiteInstance] OPenDBase];
    [self showLoginView];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
//- (void)getNetWorkStaus:(roomCreateSuccessBlock)block
//{
//    block(self.isReachable);
//    
//  
//}
-(void)reachabilityChanged:(NSNotification *)note

{
    
    Reachability *currReach = [note object];
    
    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
    
    //对连接改变做出响应处理动作
    
    self.status = [currReach currentReachabilityStatus];
    
    //如果没有连接到网络就弹出提醒实况
    
    self.isReachable = YES;
    
    NSLog(@"%d",self.status);
    
    
    switch (self.status) {
            
        case NotReachable:
            
        {
            
            //各种操作
            
            self.isReachable = NO;
            
        }
            
            break;
            
        caseReachableViaWiFi:
            
        {
            
            //各种操作
            
            self.isReachable = YES;
            
        }
            
            break;
            
        caseReachableViaWWAN:
            
        {
            
            //各种操作
            
            self.isReachable = YES;
            
        }
            
            break;
            
        default:
            
            break;
            
    }
}
//- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    return [CCOpenAPI handleOpenURL:url sourceApplication:sourceApplication];
//}
- (void)monitoringNetwork
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:AFNetworkingReachabilityDidChangeNotification
                                               object:nil];
    NSURL *baseURL = [NSURL URLWithString:@"http://www.baidu.com"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    NSOperationQueue *operationQueue = manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                self.isConnectEnabled = YES;
                [operationQueue setSuspended:YES];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.isConnectEnabled = YES;
                [operationQueue setSuspended:YES];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [operationQueue setSuspended:YES];
                self.isConnectEnabled = NO;
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    [manager.reachabilityManager startMonitoring];

}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
