//
//  OpenTableViewController.m
//  CRM
//
//  Created by 马峰 on 14-12-10.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import "OpenTableViewController.h"

@interface OpenTableViewController ()

@end

@implementation OpenTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.preferredContentSize = CGSizeMake(150, 80);

  
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    UILabel* label = [[UILabel alloc]init];
    label.frame = CGRectMake(70.0, 10.0, 100, 30);
    label.font = [UIFont systemFontOfSize:16];
    label.textColor= [UIColor blackColor];
    if (indexPath.row ==0) {
     label.text = @"是";
        
    }else if (indexPath.row ==1){
        label.text = @"否";

    
    }
    
    [cell.contentView addSubview:label];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.clickDelegate && [self.clickDelegate respondsToSelector:@selector(clickIndexPath: )]) {

        [self.clickDelegate clickIndexPath:indexPath];
        
    }


}



@end
