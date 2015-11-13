//
//  WebToViewController.h
//  CRM
//
//  Created by 马峰 on 14-12-30.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebToViewController : UIViewController<UIWebViewDelegate>
@property(nonatomic,strong) NSString* url;
@property(nonatomic,strong) NSString* titleString;
@property(nonatomic,strong) NSArray* argsArr;

@end
