//
//  SecondTableViewCell.h
//  CRM
//
//  Created by 马峰 on 14-11-27.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondTableViewCell : UITableViewCell
@property(nonatomic,strong) UIView* backGroundView;

- (void)setcellInfomation:(NSArray*)dataArray indexPath:(NSIndexPath*)indexPath;


@end
