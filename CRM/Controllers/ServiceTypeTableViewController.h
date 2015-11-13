//
//  ServiceTypeTableViewController.h
//  CRM
//
//  Created by 马峰 on 14-12-10.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol serviceTypeDelegate <NSObject>

- (void)choseTypeDelegate:(NSIndexPath*)indexPath;


@end

@interface ServiceTypeTableViewController : UITableViewController
@property(nonatomic,strong) id<serviceTypeDelegate> servicetypeDelegate;


@end
