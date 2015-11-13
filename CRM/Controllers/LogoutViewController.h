//
//  LogoutViewController.h
//  diancha
//
//  Created by Fang on 14-7-8.
//  Copyright (c) 2014年 meetrend. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WebToViewController;


@protocol LogoutViewControllerDelegate<NSObject>
@optional
- (void)cancelButtonClicked;
@end

@interface LogoutViewController : UIViewController
{
    id<LogoutViewControllerDelegate>delegate;
}

@property(nonatomic,retain)id<LogoutViewControllerDelegate>delegate;
- (void)loginOut:(WebToViewController*)webvc;


@end
