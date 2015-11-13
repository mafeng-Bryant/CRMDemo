//
//  FileView.h
//  CRM
//
//  Created by 马峰 on 14-12-29.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UrlImageButton;

@protocol jumpWebViewDelegate <NSObject>

- (void)jumeWebview:(UrlImageButton*)bt;


@end

@class MenuIcon;

@interface FileView : UIView
@property(nonatomic,strong) MenuIcon* menuIcon;
@property(nonatomic,assign) id<jumpWebViewDelegate>delegate;
@property(nonatomic,strong) NSMutableArray* menuArray;
- (void)setfileInfomation:(MenuIcon*)menuIcon;


@end
