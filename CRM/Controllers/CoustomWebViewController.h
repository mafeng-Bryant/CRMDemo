//
//  CoustomWebViewController.h
//  CRM
//
//  Created by 马峰 on 15-1-10.
//  Copyright (c) 2015年 马峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoustomWebViewController : UIViewController<UIWebViewDelegate>
@property(nonatomic,strong) NSString* url;
@property(nonatomic,strong) NSString* titleString;

@end
