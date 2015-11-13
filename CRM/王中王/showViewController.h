//
//  showViewController.h
//  CRM
//
//  Created by 马峰 on 15-1-10.
//  Copyright (c) 2015年 马峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol backDelegate <NSObject>

- (void)sendMessageWithDic:(NSDictionary*)dic;


@end


@interface showViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *bt;
@property(nonatomic,assign) id<backDelegate> delegate;
@property(nonatomic,strong) NSMutableDictionary* dataDic;

- (IBAction)back:(id)sender;

@end
