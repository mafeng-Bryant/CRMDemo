//
//  CoustomNameCell.h
//  CRM
//
//  Created by 马峰 on 14-12-5.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoustomNameCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *checkImageView;
@property (strong, nonatomic) IBOutlet UILabel *personLabel;
@property (strong, nonatomic) IBOutlet UILabel *fuzePersonLabel;

- (void)setInfomationArray:(NSArray*)coustomnameArray  indexPath:(NSIndexPath*)indexPath sting:(NSString*)loadString;




@end
