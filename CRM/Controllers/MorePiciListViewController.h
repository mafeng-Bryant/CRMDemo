//
//  MorePiciListViewController.h
//  diancha
//
//  Created by Fang on 14-7-29.
//  Copyright (c) 2014年 meetrend. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MorePiciListViewControllerDelegate <NSObject>

- (void)didSelectedPici:(NSString *)productID;

@end

@interface MorePiciListViewController : UITableViewController
{
    id<MorePiciListViewControllerDelegate>delegate;
    
    NSString *productName;
    NSArray *buffer;
}

@property(nonatomic,copy)NSString *productName;
@property(nonatomic,retain)id<MorePiciListViewControllerDelegate>delegate;

@end
