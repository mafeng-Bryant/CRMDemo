//
//  CheckListCell.m
//  diancha
//
//  Created by Fang on 14-6-30.
//  Copyright (c) 2014年 meetrend. All rights reserved.
//

#import "CheckListCell.h"
#import "DetailProduct.h"

@implementation CheckListCell
@synthesize lb_name,lb_number,lb_price;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setContent:(DetailProduct *)detailProduct
{
    
    self.lb_name.text = detailProduct.detailProductTitle;
    if ([detailProduct.priceNumber isKindOfClass:[NSString class]]) {
        self.lb_price.text = [NSString stringWithFormat:@"￥%@",detailProduct.priceNumber];
        
    }else {
        
        self.lb_price.text = [NSString stringWithFormat:@"￥%@",[detailProduct.priceNumber stringValue]];
    }
    NSInteger count = detailProduct.clickCount;
    self.lb_number.text = [@"x"stringByAppendingString:[[NSNumber numberWithInteger:count] stringValue]];
}


@end
