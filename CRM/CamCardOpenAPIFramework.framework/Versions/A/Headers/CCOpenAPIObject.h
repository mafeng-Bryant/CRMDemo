//
//  CCOpenAPIObject.h
//  CCOpenAPIFramework
//
//  Copyright (c) 2013 IntSig Information Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCOpenAPIObject : NSObject

/*!
 
 Don't change the value of appID. appID is ignored.
 */
@property (nonatomic, copy) NSString *appID;

/*!
 
 If you are authorized user, please set the app key(we assign to you) to "appKey". Or the "appKey" will be ignore.
 If you want to get a app key, please contact with us.
 */
@property (nonatomic, copy) NSString *appKey;

@property (nonatomic, copy) NSString *userID;

/*!
 
 Don't change the value of apiVersion. apiVersion is ignored.
 */
@property (nonatomic, copy) NSString *apiVersion;

- (NSDictionary *) infomation;

- (id) initWithURL:(NSURL *) url sourceApplication:(NSString *) sourceApplication;

@end

