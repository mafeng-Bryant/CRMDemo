//
//  ServiceContentTableViewController.h
//  CRM
//
//  Created by 马峰 on 14-12-10.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol serviceContentDelegate <NSObject>

- (void)choseContentDelegate:(NSIndexPath*)indexPath title:(NSString*)title;



@end

@interface ServiceContentTableViewController : UITableViewController
@property(nonatomic,assign) id<serviceContentDelegate> choseContentsDelegate;

@end
