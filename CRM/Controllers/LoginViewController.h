//
//  LoginViewController.h
//  CRM
//
//  Created by 马峰 on 14-11-26.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LoginViewDelegate <NSObject>

@optional

- (void)didLogin;

@end
@interface LoginViewController : UIViewController
@property(nonatomic,retain)id <LoginViewDelegate>delegate;

@end
