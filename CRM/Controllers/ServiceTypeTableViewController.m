//
//  ServiceTypeTableViewController.m
//  CRM
//
//  Created by 马峰 on 14-12-10.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import "ServiceTypeTableViewController.h"

@interface ServiceTypeTableViewController ()

@end

@implementation ServiceTypeTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.preferredContentSize = CGSizeMake(150, 160);

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    UILabel* label = [[UILabel alloc]init];
    label.frame = CGRectMake(65.0, 10.0, 100, 30);
    label.font = [UIFont systemFontOfSize:16];
    label.textColor= [UIColor blackColor];
    if (indexPath.row ==0) {
        label.text = @"接机";
        
    }else if (indexPath.row ==1){
        label.text = @"送机";
    }else if (indexPath.row ==2){
        label.frame = CGRectMake(55.0, 10.0, 100, 30);
   
       label.text = @"订餐预约";
    } else if (indexPath.row==3){
        label.frame = CGRectMake(55.0, 10.0, 100, 30);

        label.text = @"会议预约";
  
   }
    [cell.contentView addSubview:label];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.servicetypeDelegate && [self.servicetypeDelegate respondsToSelector:@selector(choseTypeDelegate:)]) {
        
    [self.servicetypeDelegate choseTypeDelegate:indexPath];
        
    }
}

@end
