//
//  DetailProduct.h
//  CRM
//
//  Created by 马峰 on 14-12-3.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailProduct : NSObject
@property(nonatomic,strong) NSString* detailProductId;
@property(nonatomic,strong) NSString* detailProductTitle;
@property(nonatomic,strong) NSNumber* priceNumber;
@property(nonatomic,strong) NSString* goodDescration;
@property(nonatomic,strong) NSString* fUnit;
@property(nonatomic,strong) NSString* fCreateTime;
@property(nonatomic,assign) NSInteger clickCount;

//图片id
@property(nonatomic,strong) NSString* FStoreAvatarImageId;
@property(nonatomic,strong) NSString* FMasterCatalogId;




@end
