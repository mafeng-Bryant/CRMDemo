//
//  TeaListTitleCell.m
//  diancha
//
//  Created by Fang on 14-7-2.
//  Copyright (c) 2014年 meetrend. All rights reserved.
//

#import "TeaListTitleCell.h"

@implementation TeaListTitleCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setContent:(NSDictionary *)data
{
    lb_orderName.text = [ @"订单编号:" stringByAppendingString:[data objectForKey:@"FName"] ];
 
    NSString* time = [[data objectForKey:@"FCreateTime"] substringToIndex:19];
    lb_orderTime.text = time;
}

@end
