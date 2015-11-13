//
//  BackViewController.m
//  CRM
//
//  Created by 马峰 on 15-1-22.
//  Copyright (c) 2015年 马峰. All rights reserved.
//

#import "BackViewController.h"

@interface BackViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView* dataTableView;

@end

@implementation BackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.dataTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 100, 60) style:UITableViewStylePlain];
    self.dataTableView.dataSource =self;
    self.dataTableView.delegate = self;
    [self.view addSubview:self.dataTableView];
    

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@""];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel* label = [[UILabel alloc]init];
    label.frame = CGRectMake(60.0, 5.0, 50, 30);
    label.text = @"注销";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:18.0];
    [cell.contentView addSubview:label];
    return cell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
