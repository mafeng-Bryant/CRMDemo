//
//  FileViewController.h
//  CRM
//
//  Created by 马峰 on 14-12-29.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuIcon;

@protocol clickSpaceDelegate <NSObject>

- (void)clickSpacebackMethod;


@end


@interface FileViewController : UIViewController
@property(nonatomic,assign) id<clickSpaceDelegate> spaceDelegate;
@property(nonatomic,strong) UIView* maskView;
@property(nonatomic,strong) MenuIcon* menuIcon;
@property(nonatomic,strong) UIImage* backImage;


@end
