//
//  CheckListCell.h
//  diancha
//
//  Created by Fang on 14-6-30.
//  Copyright (c) 2014年 meetrend. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailProduct;

@interface CheckListCell : UITableViewCell
{
    IBOutlet UILabel *lb_name;
    IBOutlet UILabel *lb_price;
    IBOutlet UILabel *lb_number;
}

@property (nonatomic,strong)UILabel *lb_name;
@property (nonatomic,strong)UILabel *lb_price;
@property (nonatomic,strong)UILabel *lb_number;

- (void) setContent:(DetailProduct *)detailProduct;

@end
