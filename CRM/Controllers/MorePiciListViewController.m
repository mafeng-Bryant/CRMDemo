//
//  MorePiciListViewController.m
//  diancha
//
//  Created by Fang on 14-7-29.
//  Copyright (c) 2014年 meetrend. All rights reserved.
//

#import "MorePiciListViewController.h"
#import "RRToken.h"
#import "RRLoader.h"
#import "SVProgressHUD.h"
#import "Toast+UIView.h"

@interface MorePiciListViewController ()

@end

@implementation MorePiciListViewController
@synthesize delegate,productName;

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
    
    UIBarButtonItem *btn_cancel = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navitem_back"] style:UIBarButtonItemStylePlain target:self action:@selector(btn_cancel_click:)];
    self.navigationItem.leftBarButtonItem = btn_cancel;
    
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:20],NSFontAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor whiteColor];

    self.title = @"批次列表";
    
    self.tableView.separatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"img32"]];
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [buffer count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_id = @"empty_cell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cell_id];
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    
    UIFont *font = [UIFont systemFontOfSize:15.0f];
    cell.textLabel.font = font;
    
    if ( 0 == indexPath.row) {
        cell.textLabel.text = productName;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else{
        
        NSDictionary *dic = [buffer objectAtIndex:indexPath.row-1];
        
        if ([cell.contentView viewWithTag:indexPath.row+10]) {
            [[cell.contentView viewWithTag:indexPath.row+10] removeFromSuperview];
        }
        UILabel *lb_pici = [[UILabel alloc] initWithFrame:CGRectMake(18, 10, 60, 30)];
        lb_pici.textColor = [UIColor darkGrayColor];
        lb_pici.font = font;
        lb_pici.backgroundColor = [UIColor clearColor];
        lb_pici.tag = indexPath.row + 10;
        lb_pici.text = [dic objectForKey:@"productPici"];
        [cell.contentView addSubview:lb_pici];
        
        if ([cell.contentView viewWithTag:indexPath.row+1000]) {
            [[cell.contentView viewWithTag:indexPath.row+1000] removeFromSuperview];
        }
        UILabel *lb_price = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 200, 30)];
        lb_price.textColor = dayiColor;
        lb_price.font = font;
        lb_price.backgroundColor = [UIColor clearColor];
        lb_price.tag = indexPath.row + 1000;
        lb_price.text = [NSString stringWithFormat:@"￥%@/%@",[dic objectForKey:@"storePrice"],[dic objectForKey:@"unitName"]];
        [cell.contentView addSubview:lb_price];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (0 == indexPath.row) {
        return;
    }
    NSDictionary *dic = [buffer objectAtIndex:indexPath.row-1];
    [self.delegate didSelectedPici:[dic objectForKey:@"productId"]];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)btn_cancel_click:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadData
{
    if ([buffer count] == 0)
        [SVProgressHUD showWithStatus:@"获取数据中"];
    RRToken *token = [RRToken getInstance];
  //  NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, MORE_PICI_URL];
    
	RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:nil];
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
    [req setParam:[token getProperty:@"storeId"] forKey:@"storeId"];
    [req setParam:productName forKey:@"productName"];
    
    
	[req setHTTPMethod:@"POST"];
	
	RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
	[loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onLoaded:)];
	[loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
	[loader loadwithTimer];
    
}

- (void) onLoaded: (NSNotification *)notify
{
	RRLoader *loader = (RRLoader *)[notify object];
	NSDictionary *json = [loader getJSONData];
	[loader removeNotificationListener:RRLOADER_COMPLETE target:self];
	[loader removeNotificationListener:RRLOADER_FAIL target:self];
	
	//login fail
	if (![[json objectForKey:@"success"] boolValue])
	{
        [SVProgressHUD dismissWithError:@"获取数据失败!"];
		return;
	}
    
    NSArray *arr = [[json objectForKey:@"data"] objectForKey:@"record"];
    if ([arr count] == 0) {
        [SVProgressHUD dismissWithSuccess:@"无数据!"];
        return;
    }
    [SVProgressHUD dismiss];
    buffer = arr;
    [self.tableView reloadData];
}

- (void) onLoadFail: (NSNotification *)notify
{
    [SVProgressHUD dismissWithError:@"网络错误!" afterDelay:1.5f];
	RRLoader *loader = (RRLoader *)[notify object];
	[loader removeNotificationListener:RRLOADER_COMPLETE target:self];
	[loader removeNotificationListener:RRLOADER_FAIL target:self];
}



@end
