//
//  GoodsFilterViewController.h
//  CRM
//
//  Created by 马峰 on 14-12-3.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChildProduct;
@class ProductButton;


@protocol FilterViewControllerDelegate <NSObject>

@optional
- (void)showFilterSubmenu;
- (void)hideFilterSubmenu;
- (void)didSelectNearbyRadius:(CGFloat)nearbyRadius;
- (void)didSelectBusinessDistrictID:(NSNumber *)businessDistrictID;
- (void)didSelectMerchantTypeID:(NSNumber *)merchantTypeID;

- (void)didSelectProduct:(ProductButton*)bt categoryString:(NSString*)categoryString;



@end

@interface GoodsFilterViewController : UIViewController
@property (nonatomic, assign) id<FilterViewControllerDelegate> delegate;
@property(nonatomic,strong) ChildProduct* childProduct;
@property(nonatomic,strong) UIView* maskView;

//商品。
@property(nonatomic,strong) NSArray* goodsArray;



@end
