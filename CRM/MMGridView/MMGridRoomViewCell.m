//
//  MMGridRoomViewCell.m
//  diancha
//
//  Created by Fang on 14-7-29.
//  Copyright (c) 2014年 meetrend. All rights reserved.
//

#import "MMGridRoomViewCell.h"

#define K_DEFAULT_LABEL_HEIGHT  30
#define K_DEFAULT_LABEL_INSET   5

@implementation MMGridRoomViewCell
@synthesize backgroundView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Background view
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectNull];
        self.backgroundView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backgroundView];
        
        UIImageView *im_line = [[UIImageView alloc]initWithFrame:CGRectMake(10, 190, 243, 1)];
        im_line.image = [UIImage imageNamed:@"img32"];
        [self.backgroundView addSubview:im_line];
        
        urlImage = [[UrlImageView alloc] initWithFrame:CGRectMake(9, 9, 243, 147)];
        urlImage.image = [UIImage imageNamed:@"cell-image.png"];
        [self.backgroundView addSubview:urlImage];
        
        lb_describe = [[UILabel alloc] initWithFrame:CGRectMake(0, 113, 243, 34)];
        lb_describe.textAlignment = NSTextAlignmentLeft;
        lb_describe.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        lb_describe.textColor = [UIColor whiteColor];
        lb_describe.font = [UIFont systemFontOfSize:13];
        [urlImage addSubview:lb_describe];
        
        lb_name = [[UILabel alloc] initWithFrame:CGRectMake(10, 162, 243, 22)];
        lb_name.textAlignment = NSTextAlignmentLeft;
        lb_name.backgroundColor = [UIColor clearColor];
        lb_name.textColor = [UIColor blackColor];
        lb_name.font = [UIFont systemFontOfSize:15];
        [self.backgroundView addSubview:lb_name];
        
        lb_price = [[UILabel alloc] initWithFrame:CGRectMake(10, 205,105, 22)] ;
        lb_price.textAlignment = NSTextAlignmentLeft;
        lb_price.backgroundColor = [UIColor clearColor];
        lb_price.textColor = dayiColor;
        lb_price.font = [UIFont systemFontOfSize:15];
        [self.backgroundView addSubview:lb_price];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // Background view
    self.backgroundView.frame = CGRectMake(0, 0, 262, 242);
    self.bounds = CGRectMake(0, 0, 262, 242);
    self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void) setUpCellData:(NSDictionary *)dict
{
    dataDict = dict;
    
    [urlImage setImageFromUrl:YES withUrl:[BASE_URL stringByAppendingString:[dict objectForKey:@"avatarId"] ]];
    
    lb_describe.text = [NSString stringWithFormat:@"  %@",[dict objectForKey:@"description"] ];
    lb_name.text = [dict objectForKey:@"roomName"];
    lb_price.text = [NSString stringWithFormat:@"￥%@/小时",[dict objectForKey:@"perHourPrice"]];
}

@end
