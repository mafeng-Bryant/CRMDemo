//
//  CCOpenAPI.h
//  CCOpenAPIFramework
//
//  Copyright (c) 2013 IntSig Information Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCOpenAPICommon.h"

extern NSString * const CamCardOpenAPIDidReceiveRequestNotification;
extern NSString * const CamCardOpenAPIDidReceiveResponseNotification;

@interface CCOpenAPI : NSObject

/*!
 
 Add following code to AppDelegate:
 "- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
 {
    return [CCOpenAPI handleOpenURL:url sourceApplication:sourceApplication];
 }"
 */
+ (BOOL) handleOpenURL:(NSURL *) url sourceApplication:(NSString *) sourceApplication;

/*!
 
 Check whether CamCard be installed.
 */
+ (BOOL) isCCAppInstalled;

/*!
 
 Check whether CamCard support open api.
 */
+ (BOOL) isCCAppSupportAPI;

/*!
 
 Get current open api version.
 */
+ (NSString *) currentAPIVersion;

/*!
 
 Get the address(NSString) of CamCard installation package
 */
+ (NSString *) CCAppInstallUrl;

/*!
 
 Open CamCard
 */
+ (BOOL) openCCApp;

/*!
 
 Create a request(such as CCOpenAPIRecogCardRequest or CCOpenAPIOpenCardHolderRequest),
 then send to CamCard.
 */
+ (BOOL) sendRequest:(CCOpenAPIRequest *) req;

+ (BOOL) sendRespone:(CCOpenAPIResponse *) resp;

@end
