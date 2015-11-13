//
//  ProductButton.h
//  CRM
//
//  Created by 马峰 on 14-12-3.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Product;


@interface ProductButton : UIButton
@property(nonatomic,strong) NSString* productButtonId;
@property(nonatomic,strong) Product* product;
@property(nonatomic,assign) BOOL hasSelected;


@end
