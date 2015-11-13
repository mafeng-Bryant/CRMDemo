//
//  ServiceContentTableViewController.m
//  CRM
//
//  Created by 马峰 on 14-12-10.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import "ServiceContentTableViewController.h"

@interface ServiceContentTableViewController ()
@property(nonatomic,strong) NSArray* contentsArray;

@end

@implementation ServiceContentTableViewController

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
    self.contentsArray =@[@"更换登机牌",@"协办托运行李",@"协助行李提醒服务",@"贵宾通道",@"升舱服务(高端经济舱)",@"协助查询航班动态",@"提供手提电脑收发邮件",@"免费提供无线网络",@"享受贵宾室休息",@"享受专人专职接待"];

    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.preferredContentSize = CGSizeMake(200, 400);

    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    UILabel* label = [[UILabel alloc]init];
    label.frame = CGRectMake(25.0, 10.0, 180, 30);
    label.font = [UIFont systemFontOfSize:16];
    label.textColor= [UIColor blackColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row ==0) {
        label.text = self.contentsArray[indexPath.row];
        
    }else if (indexPath.row ==1){
        label.text = self.contentsArray[indexPath.row];
    }else if (indexPath.row ==2){
        
        label.text = self.contentsArray[indexPath.row];
    }
    else if (indexPath.row ==3){
        label.text = self.contentsArray[indexPath.row];
        
    }else if (indexPath.row ==4){
         label.text = self.contentsArray[indexPath.row];
    }
    else if (indexPath.row ==5){
        label.text = self.contentsArray[indexPath.row];
        
    }else if (indexPath.row ==6){
        label.text = self.contentsArray[indexPath.row];
    }
    else if (indexPath.row ==7){
        label.text = self.contentsArray[indexPath.row];
        
    }else if (indexPath.row ==8){
        label.text = self.contentsArray[indexPath.row];
    }else if (indexPath.row ==9){
        label.text = self.contentsArray[indexPath.row];
    }
    
    [cell.contentView addSubview:label];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return;
    
    if (self.choseContentsDelegate && [self.choseContentsDelegate respondsToSelector:@selector(choseContentDelegate: title:)]) {
        
        [self.choseContentsDelegate choseContentDelegate:indexPath title:self.contentsArray[indexPath.row]];
        
    }
}


@end
