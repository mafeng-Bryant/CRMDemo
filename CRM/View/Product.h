//
//  Product.h
//  CRM
//
//  Created by 马峰 on 14-12-3.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ChildProduct;

@interface Product : NSObject
@property(nonatomic,strong) NSString* comendProductId;
@property(nonatomic,strong) NSString* commendTitle;
@property(nonatomic,strong) NSMutableArray* childArray;//装载一级菜单下的产品 对象为ChildProduct
@property(nonatomic,strong) ChildProduct* childProduct;

@end
