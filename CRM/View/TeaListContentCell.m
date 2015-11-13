//
//  TeaListContentCell.m
//  diancha
//
//  Created by Fang on 14-7-2.
//  Copyright (c) 2014年 meetrend. All rights reserved.
//

#import "TeaListContentCell.h"

@implementation TeaListContentCell

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
    
    
    [im_avatar setImageFromUrl:YES withUrl:[BASE_URL stringByAppendingString:[data objectForKey:@"FStoreAvatarId"]]];
    
    lb_name.text = [data objectForKey:@"FProductId$"];
    
    lb_unitPrice.text = [NSString stringWithFormat:@"单价: %@/%@",[data objectForKey:@"FUnitPrice"],[data objectForKey:@"FUnit"]];
    

    lb_amount.text = [NSString stringWithFormat:@"数量: %@%@",[data objectForKey:@"FQuantity"],[data objectForKey:@"FUnit"]];
    
    lb_price.text = [NSString stringWithFormat:@"总金额: ￥%@",[data objectForKey:@"FDetailAmount"]];
    
    if(!IOS7){
        lb_amount.textAlignment = NSTextAlignmentLeft;
        lb_price.textAlignment = NSTextAlignmentLeft;
    }
}

@end
