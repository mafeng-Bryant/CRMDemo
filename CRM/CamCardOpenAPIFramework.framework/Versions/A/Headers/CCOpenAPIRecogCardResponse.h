//
//  CCOpenAPIRecogCardResponse.h
//  CCOpenAPIFramework
//
//  Copyright (c) 2013 IntSig Information Co., Ltd. All rights reserved.
//

#import "CCOpenAPIResponse.h"

@interface CCOpenAPIRecogCardResponse : CCOpenAPIResponse

/*!
 
 the business card image which has been trimming and enhancement.
 */
@property (nonatomic, retain) UIImage *cardImage;

/*!
 
 vcfString contain the information on business card, and follow the vCard format.
 */
@property (nonatomic, copy) NSString *vcfString;

@end
