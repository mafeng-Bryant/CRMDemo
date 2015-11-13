//
//  ChildProduct.h
//  CRM
//
//  Created by 马峰 on 14-12-3.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChildProduct : NSObject
@property(nonatomic,strong) NSString* secondProductId;
@property(nonatomic,strong) NSString* secondProductTitle;
@property(nonatomic,strong) NSMutableArray* secondChildArray;//装载二级菜单下的产品。

@end
