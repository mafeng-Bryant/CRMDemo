//
//  StoreCell.m
//  CRM
//
//  Created by 马峰 on 15-2-2.
//  Copyright (c) 2015年 马峰. All rights reserved.
//

#import "StoreCell.h"
#import "StoreModel.h"

@implementation StoreCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInfomationArray:(NSArray*)coustomnameArray indexPath:(NSIndexPath*)indexPath sting:(NSString*)loadString
{
    if ([loadString isEqualToString:@"allload"]) {
        StoreModel* model = coustomnameArray[indexPath.row];
        self.storeLabel.text = model.storeName;
    }else if ([loadString isEqualToString:@"findString"]){
        
        NSDictionary* dic =[coustomnameArray objectAtIndex:indexPath.row];
        self.storeLabel.text = [dic objectForKey:@"FName"];

    }

}


@end
