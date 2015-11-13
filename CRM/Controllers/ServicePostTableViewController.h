//
//  ServicePostTableViewController.h
//  CRM
//
//  Created by 马峰 on 15-2-2.
//  Copyright (c) 2015年 马峰. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol choseServicePostDelegate <NSObject>

- (void)choseServicePostString:(NSString*)string title:(NSString*)title;

@end
@interface ServicePostTableViewController : UITableViewController
@property(nonatomic,assign) id<choseServicePostDelegate> servicePostDelegate;
@end
