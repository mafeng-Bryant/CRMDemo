//
//  AirportCell.m
//  CRM
//
//  Created by 马峰 on 15-2-9.
//  Copyright (c) 2015年 马峰. All rights reserved.
//

#import "AirportCell.h"
#import "AirportModel.h"

@implementation AirportCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setInfomationArray:(NSArray*)airportmnameArray indexPath:(NSIndexPath*)indexPath sting:(NSString*)loadString
{
    if ([loadString isEqualToString:@"allload"]) {
        AirportModel* model = airportmnameArray[indexPath.row];
        self.airportNameLabel.text = model.fName;
    }else if ([loadString isEqualToString:@"findString"]){
   
        
        NSDictionary* dic =[airportmnameArray objectAtIndex:indexPath.row];
        self.airportNameLabel.text = [dic objectForKey:@"FName"];
        
    }

}
@end
