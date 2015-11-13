//
//  WViewController.h
//  CRM
//
//  Created by 马峰 on 15-1-10.
//  Copyright (c) 2015年 马峰. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <recognizeAPI/cardRecognizedData.h>

@interface WViewController : UIViewController<UIWebViewDelegate>
@property(nonatomic,strong) NSString* url;
@property(nonatomic,strong) NSString* titleString;

@end
