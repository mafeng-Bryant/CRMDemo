//
//  PopViewController.m
//  CRM
//
//  Created by 马峰 on 14-11-27.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import "PopViewController.h"

@interface PopViewController ()

@end

@implementation PopViewController

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
    
    self.tableView.showsHorizontalScrollIndicator= NO;
    self.tableView.showsVerticalScrollIndicator = NO;

   
    self.view.backgroundColor = [UIColor yellowColor];
    
    CGRect rect = self.view.frame;
    
    rect.size.width =200;
    rect.size.height = 50;
    self.view.frame = rect;

    self.tableView.frame = rect;
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



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
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.loginOutDelegate && [self.loginOutDelegate respondsToSelector:@selector(didLoginOut)]) {
        
        [self.loginOutDelegate didLoginOut];
    }
}
@end
