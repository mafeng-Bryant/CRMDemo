//
//  CCOpenAPIOpenCardHolderRequest.h
//  CCOpenAPIFramework
//
//  Copyright (c) 2013 IntSig Information Co., Ltd. All rights reserved.
//

#import "CCOpenAPIRequest.h"

/*!
 
 @class CCOpenAPIOpenCardHolderRequest
 @abstract If you want to open CamCard's CardHolder, you could send a request of this type to CamCard.
 NOTE:
 1. Init: you must call "init" to create this type request.
 2. You must assign a value to "CCAppVersion".
 3. If you need to, you could assign a value to "appKey"
 */
@interface CCOpenAPIOpenCardHolderRequest : CCOpenAPIRequest

@end
