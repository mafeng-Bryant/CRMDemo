//
//  CCOpenAPIBaseResp.h
//  CCOpenAPIFramework
//
//  Copyright (c) 2013 IntSig Information Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCOpenAPIObject.h"

/*!
 
 @class CCOpenAPIResponse
 @abstract associate with CCOpenAPIRequest. when send a request to CamCard, you mybe receive a response from CamCard.
 @attribute responseCode: it could be assign as following value:
 5001: The time of authorized infomation expired.
 5002: Do not support the language your request.
 5003: As unauthorized app, amount has been used out.
 5004: As authorized app, amount has been used out.
 5005: As authrized app, you are over device quota.
 5006: unkown error.
 0: no error.
 */
@interface CCOpenAPIResponse : CCOpenAPIObject

@property (nonatomic, assign) NSInteger responseCode;

@end
