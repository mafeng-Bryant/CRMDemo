//
//  TeaListContentCell.h
//  diancha
//
//  Created by Fang on 14-7-2.
//  Copyright (c) 2014年 meetrend. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlImageView.h"

@protocol refreShPriceInformationDelegate <NSObject>

- (void)refreshPrice;

@end


@interface TeaListContentCell : UITableViewCell
{
    IBOutlet UrlImageView *im_avatar;
    IBOutlet UILabel *lb_name;
    IBOutlet UILabel *lb_amount;
    IBOutlet UILabel *lb_price;
    IBOutlet UILabel *lb_unitPrice;
}
@property(nonatomic,assign) id<refreShPriceInformationDelegate> priceDelegate;
- (void) setContent:(NSDictionary *)data;

@end
