//
//  ChoseAirportTableViewController.m
//  CRM
//
//  Created by 马峰 on 15-1-7.
//  Copyright (c) 2015年 马峰. All rights reserved.
//

#import "ChoseAirportTableViewController.h"

@interface ChoseAirportTableViewController ()
@property(nonatomic,strong) NSArray* listArray;

@end

@implementation ChoseAirportTableViewController

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
    
    self.listArray = @[@"高崎机场",@"天河机场"];
    self.preferredContentSize = CGSizeMake(150, 80);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
    if (self.choseAirportDelegate && [self.choseAirportDelegate respondsToSelector:@selector(ChoseAirportclickIndexPath:titleString: type:)]) {
        
        if (indexPath.row==0) {
            
            string = @"GQ";
            
        }else if (indexPath.row ==1){
            
            string = @"TH";
            
        }
        [self.choseAirportDelegate ChoseAirportclickIndexPath:string titleString:self.listArray[indexPath.row] type:self.airportType];
    }
}


@end
