//
//  PopViewController.h
//  CRM
//
//  Created by 马峰 on 14-11-27.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol clickLoginOutDelegate <NSObject>

- (void)didLoginOut;


@end

@interface PopViewController : UITableViewController

@property(nonatomic,assign) id<clickLoginOutDelegate> loginOutDelegate;


@end
