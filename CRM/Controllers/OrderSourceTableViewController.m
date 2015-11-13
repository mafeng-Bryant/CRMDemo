//
//  OrderSourceTableViewController.m
//  CRM
//
//  Created by 马峰 on 14-12-10.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import "OrderSourceTableViewController.h"

@interface OrderSourceTableViewController ()
@property(nonatomic,strong) NSArray* listArray;

@end

@implementation OrderSourceTableViewController

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
    self.listArray = @[@"交行APP",@"微店",@"微信",@"礼程网",@"POS",@"手工新增"];
    self.preferredContentSize = CGSizeMake(150, 240);
    
    
    
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
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
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

     NSString* string = nil;
    if (self.orderDelegate && [self.orderDelegate respondsToSelector:@selector(OrderResourceclickIndexPath: titleString:)]) {
        
        if (indexPath.row==0) {
      
         string = @"jhapp";
            
        }else if (indexPath.row ==1){
        
            string = @"weidian";

        }else if (indexPath.row ==2){
            
            string = @"weixin";
  
        }else if (indexPath.row ==3){
            string = @"lichengwang";
  
            
        }else if (indexPath.row ==4){
            
            string = @"pos";
  
        }else if (indexPath.row ==5){
            
            string = @"shougong";
  
        }
        [self.orderDelegate OrderResourceclickIndexPath:string titleString:self.listArray[indexPath.row]];
    }
}






@end