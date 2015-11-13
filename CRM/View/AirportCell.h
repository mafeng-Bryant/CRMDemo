//
//  AirportCell.h
//  CRM
//
//  Created by 马峰 on 15-2-9.
//  Copyright (c) 2015年 马峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirportCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *chectImageView;
@property (strong, nonatomic) IBOutlet UILabel *airportNameLabel;

- (void)setInfomationArray:(NSArray*)airportmnameArray indexPath:(NSIndexPath*)indexPath sting:(NSString*)loadString;
@end
