//
//  StoreCell.h
//  CRM
//
//  Created by 马峰 on 15-2-2.
//  Copyright (c) 2015年 马峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *checkImageView;

@property (strong, nonatomic) IBOutlet UILabel *storeLabel;

- (void)setInfomationArray:(NSArray*)coustomnameArray indexPath:(NSIndexPath*)indexPath sting:(NSString*)loadString;
@end
