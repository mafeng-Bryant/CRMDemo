//
//  OpenTableViewController.h
//  CRM
//
//  Created by 马峰 on 14-12-10.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol clickIndexPathRowDelegate <NSObject>

- (void)clickIndexPath:(NSIndexPath*)indexPath;


@end

@interface OpenTableViewController : UITableViewController

@property(nonatomic,assign) id<clickIndexPathRowDelegate> clickDelegate;

@end
