//
//  CoustomNameCell.m
//  CRM
//
//  Created by 马峰 on 14-12-5.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import "CoustomNameCell.h"
#import "CoustomModel.h"

@implementation CoustomNameCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInfomationArray:(NSArray*)coustomnameArray  indexPath:(NSIndexPath*)indexPath sting:(NSString*)loadString
{
    if ([loadString isEqualToString:@"allload"]) {
        CoustomModel* model = coustomnameArray[indexPath.row];
        self.personLabel.text = model.name;
        self.fuzePersonLabel.text = [NSString stringWithFormat:@"负责人:%@",model.responsibleName];
    }else if ([loadString isEqualToString:@"findString"]){
    
        NSDictionary* dic=[coustomnameArray objectAtIndex:indexPath.row];
        self.personLabel.text = [dic objectForKey:@"FName"];
        self.fuzePersonLabel.text = [dic objectForKey:@"FUser"];
        
    }
}

@end
