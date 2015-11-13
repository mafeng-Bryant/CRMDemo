//
//  PostTableViewController.m
//  CRM
//
//  Created by 马峰 on 15-2-2.
//  Copyright (c) 2015年 马峰. All rights reserved.
//

#import "PostTableViewController.h"

@interface PostTableViewController ()
@property(nonatomic,strong) NSArray* listArray;

@end

@implementation PostTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listArray = @[@"现货先结",@"货到付款",@"款到发货"];
    self.preferredContentSize = CGSizeMake(150, 120);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    UILabel* label = [[UILabel alloc]init];
    label.frame = CGRectMake(40.0, 10.0, 100, 30);
    label.font = [UIFont systemFontOfSize:16];
    label.textColor= [UIColor blackColor];
    label.text = self.listArray[indexPath.row];
    [cell.contentView addSubview:label];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString* string = nil;
    if (self.postDelegate && [self.postDelegate respondsToSelector:@selector(chosePostString: title:)]) {
        
        if (indexPath.row==0) {
            
            string = @"xianhuoxianjie";
            
        }else if (indexPath.row ==1){
            
            string = @"huodaofukuan";
            
        }
        else if (indexPath.row ==2){
            
            string = @"kuandaofuhuo";
            
        }
        [self.postDelegate chosePostString:string title:self.listArray[indexPath.row]];
    }
}



@end
