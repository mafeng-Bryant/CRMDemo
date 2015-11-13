//
//  PostTableViewController.h
//  CRM
//
//  Created by 马峰 on 15-2-2.
//  Copyright (c) 2015年 马峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol chosePostDelegate <NSObject>

- (void)chosePostString:(NSString*)string title:(NSString*)title;



@end


@interface PostTableViewController : UITableViewController
@property(nonatomic,assign) id<chosePostDelegate> postDelegate;

@end
