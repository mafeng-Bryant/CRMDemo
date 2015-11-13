//
//  PackTableViewController.h
//  CRM
//
//  Created by 马峰 on 15-1-7.
//  Copyright (c) 2015年 马峰. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol pageClickIndexPathRowDelegate <NSObject>

- (void)pageclickIndexPath:(NSIndexPath*)indexPath;
@end

@interface PackTableViewController : UITableViewController
@property(nonatomic,assign) id<pageClickIndexPathRowDelegate> pageClickDelegate;

@end
