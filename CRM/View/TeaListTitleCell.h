//
//  TeaListTitleCell.h
//  diancha
//
//  Created by Fang on 14-7-2.
//  Copyright (c) 2014年 meetrend. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeaListTitleCell : UITableViewCell
{
    IBOutlet UILabel *lb_orderName;
    IBOutlet UILabel *lb_orderPrice;
    IBOutlet UILabel *lb_orderTime;
}

- (void) setContent:(NSDictionary *)data;

@end
