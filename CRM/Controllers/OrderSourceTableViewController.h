//
//  OrderSourceTableViewController.h
//  CRM
//
//  Created by 马峰 on 14-12-10.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderResourceclickIndexPathRowDelegate <NSObject>

- (void)OrderResourceclickIndexPath:(NSString*)string titleString:(NSString*)title;



@end
@interface OrderSourceTableViewController : UITableViewController

@property(nonatomic,assign) id<OrderResourceclickIndexPathRowDelegate> orderDelegate;

@end
